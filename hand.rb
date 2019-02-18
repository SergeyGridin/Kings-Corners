class Hand

	def self.deal_from(deck)
		Hand.new(deck.take(7))
	end

	attr_accessor :cards

	def initialize(cards)
		@cards = cards
	end


	def pick_card_from_hand(pos)
		picked = @cards[pos]
		@cards[pos] = nil
		@cards.compact!
		picked
	end


end