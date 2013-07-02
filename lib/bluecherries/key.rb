class BadHandError < StandardError
end

class Key
  def initialize(char, hand, row_number)
    if hand == :left or hand == :right
      @hand = hand
    else
      raise BadHandError
    end

    @char = char
    @row_number = row_number
  end

  private

  attr_reader :char, :hand, :row_number
end
