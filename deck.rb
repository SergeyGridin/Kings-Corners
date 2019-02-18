require_relative 'card'


class Deck
  def self.all_cards
    all_cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end
    all_cards.shuffle
  end

  attr_accessor :deck

  def initialize(cards = Deck.all_cards)
    @deck = cards
  end


  def count
    @deck.count
  end


  def take(n)
    raise "deck is empty, continue without taking any cards" if count < 1
    @deck.shift(n)
  end

end