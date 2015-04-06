module BlueCherries
  class LeftHandTwoLetterMotions
    HORIZONTAL_LEFT_HAND_KEYS = 5
    HORIZONTAL_RIGHTMOST_POSITION = 4

    def initialize(layout_chars)
      @layout_chars = layout_chars
    end

    def generate
      [
        same_row_adjacent_right,
        same_row_adjacent_left,
        same_row_one_space_between_right,
        same_row_one_space_between_left,
        same_row_two_spaces_between_right,
        same_row_two_spaces_between_left,
        same_row_three_spaces_between_right,
        same_row_three_spaces_between_left,
        two_rows_same_column_up,
        two_rows_same_column_down,
        two_rows_adjacent_up_right,
        two_rows_adjacent_down_left,
        two_rows_one_space_between_right,
        two_rows_one_space_between_left,
      ].flatten
    end

    private

    attr_reader :layout_chars

    def left_hand_character_rows
      layout_chars.map { |row| row.first(HORIZONTAL_LEFT_HAND_KEYS) }
    end

    def same_row_adjacent_right
      left_hand_character_rows.map do |row|
        0.upto(row.length - 2).map do |col|
          row[col] + row[col+1]
        end
      end.flatten
    end

    def same_row_adjacent_left
      same_row_adjacent_right.map(&:reverse)
    end

    def same_row_one_space_between_right
      left_hand_character_rows.map do |row|
        0.upto(row.length - 3).map do |col|
          row[col] + row[col + 2]
        end
      end.flatten
    end

    def same_row_one_space_between_left
      same_row_one_space_between_right.map(&:reverse)
    end

    def same_row_two_spaces_between_right
      left_hand_character_rows.map do |row|
        0.upto(row.length - 4).map do |col|
          row[col] + row[col+3]
        end
      end.flatten
    end

    def same_row_two_spaces_between_left
      same_row_two_spaces_between_right.map(&:reverse)
    end

    def same_row_three_spaces_between_right
      left_hand_character_rows.map { |row| row[0] + row[4] }
    end

    def same_row_three_spaces_between_left
      same_row_three_spaces_between_right.map(&:reverse)
    end

    def two_rows_same_column_up
      upper_two_rows = 2.upto(HORIZONTAL_RIGHTMOST_POSITION).map do |col|
        left_hand_character_rows[1][col] + left_hand_character_rows[0][col]
      end
      lower_two_rows = 1.upto(HORIZONTAL_RIGHTMOST_POSITION).map do |col|
        left_hand_character_rows[2][col] + left_hand_character_rows[1][col]
      end

      upper_two_rows + lower_two_rows
    end

    def two_rows_same_column_down
      upper_two_rows = 2.upto(HORIZONTAL_RIGHTMOST_POSITION).map do |col|
        left_hand_character_rows[0][col] + left_hand_character_rows[1][col]
      end
      lower_two_rows = 1.upto(HORIZONTAL_RIGHTMOST_POSITION).map do |col|
        left_hand_character_rows[1][col] + left_hand_character_rows[2][col]
      end

      upper_two_rows + lower_two_rows
    end

    def two_rows_adjacent_up_right
      [1, 2].map do |row|
        0.upto(HORIZONTAL_RIGHTMOST_POSITION - 2).map do |col|
          left_hand_character_rows[row][col] +
            left_hand_character_rows[row - 1][col + 1]
        end
      end.flatten
    end

    def two_rows_adjacent_down_left
      [0, 1].map do |row|
        1.upto(HORIZONTAL_RIGHTMOST_POSITION - 1).map do |col|
          left_hand_character_rows[row][col] +
            left_hand_character_rows[row + 1][col - 1]
        end
      end.flatten
    end

    def two_rows_one_space_between_right
      [1, 2].map do |row|
        0.upto(HORIZONTAL_RIGHTMOST_POSITION - 2).map do |col|
          left_hand_character_rows[row][col] +
            left_hand_character_rows[row - 1][col + 2]
        end
      end
    end

    def two_rows_one_space_between_left
      [0, 1].map do |row|
        2.upto(HORIZONTAL_RIGHTMOST_POSITION).map do |col|
          left_hand_character_rows[row][col] +
            left_hand_character_rows[row + 1][col - 2]
        end
      end
    end
  end
end
