module BlueCherries
  class MissingLayoutError < Exception
  end

  class Layout
    attr_reader :name, :keys

    def initialize(name = :qwerty)
      begin
        layout_file = File.open layout_path(name.to_s)
      rescue Errno::ENOENT
        raise MissingLayoutError, "ERROR: The layout file for "\
                                  "#{name.to_s.upcase} doesn't exist."
      end

      @keys = layout_to_keys(layout_file)
      @name = name
    end

    def motions
      left_hand_motions = left_index_finger_motions
      right_hand_motions = right_index_finger_motions

      return left_hand_motions + right_hand_motions
    end

    private

    def layout_to_keys(layout_file)
      rows = layout_file.readlines.map(&:chomp)
      rows_of_keys = rows.map.with_index(1) do |row, row_number|
        row.chars.map.with_index(1) do |char, column_number|
          Key.new(char, column_number, row_number)
        end
      end

      return rows_of_keys.flatten
    end

    def layout_path(name)
      File.expand_path("../../../layouts/#{name}.layout", __FILE__)
    end

    def right_index_finger_motions
      [
        Motion.new(:y),
        Motion.new(:h),
        Motion.new(:n),
        Motion.new(:u),
        Motion.new(:j),
        Motion.new(:m)
      ]
    end

    def left_index_finger_motions
      [
        Motion.new(:t),
        Motion.new(:g),
        Motion.new(:b),
        Motion.new(:r),
        Motion.new(:f),
        Motion.new(:v)
      ]
    end
  end
end
