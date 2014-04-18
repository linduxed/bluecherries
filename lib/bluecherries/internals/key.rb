module BlueCherries
  class Key
    attr_reader :char, :row_number

    def initialize(char, column_number, row_number)
      @char = char
      @column_number = column_number
      @row_number = row_number
    end

    def hand
      if @column_number <= 5
        :left
      else
        :right
      end
    end
  end
end
