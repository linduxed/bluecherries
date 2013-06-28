require "bluecherries/version"

module BlueCherries
  class Layout
    def initialize(layout = :qwerty)
      begin
        layout_file = File.open layout_path(layout.to_s)
      rescue Errno::ENOENT
        puts "ERROR: The layout file for #{layout.to_s.upcase} doesn't exist."
        exit
      end

      @keys = layout_file.readlines.map(&:chomp)
    end

    def motions
      left_hand_motions = left_index_finger_motions
      right_hand_motions = right_index_finger_motions

      return left_hand_motions + right_hand_motions
    end

    private

    attr_reader :keys, :layout

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

  # Defines the different motions that one can do with one hand that result in
  # a sequence of pressed keys.
  class Motion
    attr_reader :keys

    def initialize(keys)
      @keys = keys
    end
  end
end
