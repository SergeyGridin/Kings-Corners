require_relative 'deck'
require 'byebug'
class Board

	PILES = {
		:n => [0, 1],
		:e => [1, 2],
		:w => [1, 0],
		:s => [2, 1]
	}

	CORNERS = {
		:nw => [0, 0],
		:ne => [0, 2],
		:sw => [2, 0],
		:se => [2, 2]
	}

	attr_accessor :board, :deck

	def initialize(deck)
		@board = Array.new(3) { Array.new(3) {[]}}
		@deck = deck
		populate
	end

	def [](pos)
		row, col = pos
		@board[row][col]
	end

	def []=(pos, card)
		row, col = pos
		@board[row][col] = card
	end

	def populate
		PILES.values.each do |pos|
			card = @deck.take(1)         
			self[pos] = card 
		end
	end

	def valid_move?(picked, pos)
		raise "Invalid position!" unless (0..2).include?(pos[0]) && (0..2).include?(pos[0]) && pos != [1, 1]
		if picked.first.value == :king
			if CORNERS.values.include?(pos)
				true
			else
				raise "You need to move king to the corner!"
			end
		end
		unless self[pos].empty? 
			board_card = self[pos].last
			hand_card = picked.first 
			if (board_card.value_at - hand_card.value_at == 1) && board_card.color != hand_card.color
				true
			else
				raise "Can't move here!"
			end
		end
		if self[pos].empty? && CORNERS.values.include?(pos) && picked.first.value != :king
			false
		else
			true
		end
	end

	def pick_pile(pos)
		picked = self[pos]
		self[pos] = []
		picked
	end

	def move(picked, pos)
		self[pos].concat(picked)
	end

	def render
		(0..2).each do |row|
			arr = []
			(0..2).each do |col|
				array_of_cards = self[[row, col]]
				bottom_card = array_of_cards.first.card_string unless array_of_cards.empty?
				top_card = array_of_cards.last.card_string unless array_of_cards.empty?
				pos = [row, col]
				if PILES.values.include?(pos) 
					if array_of_cards.empty?
						arr << "____"
					elsif array_of_cards.length == 1
						arr << (" " + bottom_card + " ").colorize(:color => :black, :background => :green)
					else
						arr << (bottom_card + "/" + top_card).colorize(:color => :black, :background => :green)
					end
				elsif CORNERS.values.include?(pos)
					if array_of_cards.empty?
						arr << "____"
					elsif array_of_cards.length == 1
						arr << (" " + bottom_card + " ").colorize(:color => :black, :background => :red)
					else
						arr << (bottom_card + "/" + top_card).colorize(:color => :black, :background => :red)
					end
				else
					arr << (" " + @deck.count.to_s + " ").colorize(:color => :black, :background => :blue)
				end
			end
			puts arr.join("  ")
			puts
		end
	end


	def remove_cards_from_board
		(0..2).each do |row|
			(0..2).each do |col|
				until board[row][col].empty?
					@deck.deck << board[row][col].shift
				end
			end
		end
	end

end