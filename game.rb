require 'colorize'
require_relative "board"
require_relative "player"
require 'byebug'

class Game

	attr_reader :players, :board, :deck
	
	def initialize(board, players, deck)
		@deck = deck
		@board = board
		@players = players.map { |pl| Player.new(pl, deck)}
	end


	def game_over?
		winners = players.count { |e| e.points < 25 }
		winners == 1
	end

	def play_game
		round = 0
		until game_over?
			if round == 0
				puts "Welcome to Kings Corners!"
			else
				players.each { |pl| puts "#{pl.name} has #{pl.points} points"}
			end
			play_round
			round += 1
			board.remove_cards_from_board
			players.each { |pl| pl.remove_cards_from_hand }
			@deck.deck.shuffle
			@board.populate
			players.each do |pl| 
				pl.hit_seven unless pl.points > 25
			end
		end
		winner = players.select { |pl| pl.points < 25 }
		puts "#{winner.first} "
	end


	def play_round
		until players.any? {|pl| pl.won? }
			players.each do |player|
				next if player.points > 25
				turn = true if players.none? { |pl| pl.won?}
				while turn
					begin
						puts "#{player.name} your turn!"
						@board.render
						arr_cards = []
						player.hand.cards.each { |c| arr_cards << c.card_string + "-(#{player.hand.cards.index(c)})  "}
						puts arr_cards.join(" ")
						puts "type 'h' to pick a card form your hand"
						puts "type 'b' to move piles on the board"
						puts "type 'e' to end move"
						input = gets.chomp
						if input == "h"
							puts "Enter the position of the card you want to move: "
							pos1 = gets.chomp.to_i
							if player.valid_hand_pick(pos1)
								puts "Enter the position on the board to place the card: "
								pos = gets.chomp.split(",").map { |e| e.to_i }
								if board.valid_move?([player.hand.cards[pos1]], pos)
									picked = [player.hand.pick_card_from_hand(pos1)]
									board.move(picked, pos)
								end
							end

						elsif input == "b"
							puts "Enter the position of the pile you want to move: "
							pos1 = gets.chomp.split(",").map { |e| e.to_i }
								raise "It is the deck!" if pos1 == [1,1]
							puts "Enter the position on the board to where you want to move the pile "
							pos2 = gets.chomp.split(",").map { |e| e.to_i }
							if board.valid_move?(board[pos1], pos2)
								picked = board.pick_pile(pos1)
								board.move(picked, pos2)
							end

						elsif input == "e"
							player.hit unless @deck.deck.empty? || player.won?
							system "clear"
							turn = false
							next
						end
					rescue StandardError => e
						puts "Try Again!: #{e.message}"
						retry
					end
				end
			end
		end
		
		players.each { |pl| pl.count_points }

	end


end



def game_setup
	players = nil
	begin
		puts "Enter number of players (2-4): "
		input = gets.chomp.to_i
		case input
		when 2
			players = ["player1", "player2"]
		when 3
			players = ["player1", "player2", "player3"]
		when 4
			players = ["player1", "player2", "player3", "player4"]
		else
			raise "Invalid number of players! Enter 2, 3 or 4!"
		end
		
	rescue StandardError => e
		puts "Try again! #{e.message}"
		retry
	end
	d = Deck.new
	b = Board.new(d)
	g = Game.new(b, players, d)
	g.play_game
end
	

game_setup