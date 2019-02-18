class Card

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  VALUE_STRINGS = {
		:ace   => 1,
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13
  }

  GAME_VALUE = {
    :ace   => 1,
    :deuce => 1,
    :three => 1,
    :four  => 1,
    :five  => 1,
    :six   => 1,
    :seven => 1,
    :eight => 1,
    :nine  => 1,
    :ten   => 1,
    :jack  => 1,
    :queen => 1,
    :king  => 10
  }

	def self.suits
    SUIT_STRINGS.keys
	end
	
	def self.values
    VALUE_STRINGS.keys
	end
	
	attr_reader :suit, :value

	def initialize(suit, value)
    unless Card.suits.include?(suit) && Card.values.include?(value)
      fail "illegal suit (#{suit}) or value (#{value})"
    end

    @suit, @value = suit, value
  end

  def color
    return :black if self.suit == :clubs || self.suit == :spades
    return :red if self.suit == :hearts || self.suit == :diamonds
  end

  def value_at
    VALUE_STRINGS[self.value]
  end

  def card_points
    GAME_VALUE[self.value]
  end

  def card_string
    STRINGS[self.value] + SUIT_STRINGS[self.suit]
  end
    
end