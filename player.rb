require_relative "hand"
class Player
  
	attr_reader :name
	attr_accessor :points, :hand, :deck

	def initialize(name, deck)
		@deck = deck
		@name = name
		@points = 0
		@hand = Hand.deal_from(deck)
	end


	def valid_hand_pick(pos)
		if pos.is_a?(Integer)
			unless @hand.cards[pos].nil?
				return true
			else
				raise "You don have that many cards!"
			end
		end
	end

	def hit_seven
		hand.cards.concat(@deck.take(7))
	end
	
	def hit
		hand.cards.concat(@deck.take(1))
	end

	def won?
		@hand.cards.empty? 
	end

	def count_points
		sum = 0
		@hand.cards.each { |card| sum += card.card_points }
		@points += sum
	end

	def empty_hand
		@hand = Hand.deal_from(deck)
	end

	def remove_cards_from_hand
		@deck.deck += self.hand.cards.shift(self.hand.cards.length)
	end

end