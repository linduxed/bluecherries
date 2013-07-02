class Layout
  attr_reader :name

  def initialize(name = :qwerty)
    begin
      layout_file = File.open layout_path(name.to_s)
    rescue Errno::ENOENT
      puts "ERROR: The layout file for #{name.to_s.upcase} doesn't exist."
      exit
    end

    rows = layout_file.readlines.map(&:chomp)
    rows_of_keys = rows.map.with_index(1) do |row, row_number|
      # TODO: implement method which sets the hand correctly.
      row.chars.map { |char| Key.new(char, :left, row_number) }
    end
    @keys = rows_of_keys.flatten

    @name = name
  end

  def motions
    left_hand_motions = left_index_finger_motions
    right_hand_motions = right_index_finger_motions

    return left_hand_motions + right_hand_motions
  end

  private

  attr_reader :keys

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
