module BlueCherries
  class MissingLayoutError < Exception; end

  class Layout
    attr_reader :name

    def initialize(name = :qwerty)
      @name = name
    end

    def keys
      @keys ||= extract_keys_from_layout_file
    end

    def motions
      left_hand_motions = left_index_finger_motions
      right_hand_motions = right_index_finger_motions

      left_hand_motions + right_hand_motions
    end

    private

    def extract_keys_from_layout_file
      rows_of_keys = rows_from_file.map.with_index(1) do |row, row_number|
        row.chars.map.with_index(1) do |char, column_number|
          Key.new(char, column_number, row_number)
        end
      end

      rows_of_keys.flatten
    end

    def rows_from_file
      File.readlines(layout_path).map(&:chomp)
    rescue Errno::ENOENT
      raise MissingLayoutError, "ERROR: The layout file for "\
                                "#{@name.to_s.upcase} doesn't exist."
    end


    def layout_path
      File.expand_path("../../../layouts/#{@name.to_s}.layout", __FILE__)
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
