require "bluecherries/version"

module BlueCherries
  class Layout
    attr_reader :name, :keys

    def initialize(name = :qwerty)
      begin
        layout_file = File.open layout_path(name.to_s)
      rescue Errno::ENOENT
        $stderr.puts "ERROR: The layout file for #{name.to_s.upcase} "\
                     "doesn't exist."
        exit 1
      end

      @name = name

      rows = layout_file.readlines.map(&:chomp)
      rows_of_keys = rows.map.with_index(1) do |row, row_number|
        row.chars.map { |char| Key.new(char, row_number) }
      end

      @keys = rows_of_keys.flatten
    end

    def motions
      left_hand_motions = left_index_finger_motions
      right_hand_motions = right_index_finger_motions

      return left_hand_motions + right_hand_motions
    end

    private

    def layout_path(name)
      File.expand_path("../../layouts/#{name}.layout", __FILE__)
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

  class Key
    def initialize(char, row_number)
      @char = char
      @row_number = row_number
    end

    private

    attr_reader :char, :row_number
  end

  # Defines the different motions that one can do with one hand that result in
  # a sequence of pressed keys.
  class Motion
    attr_reader :keys

    def initialize(keys)
      @keys = keys
    end
  end
end
