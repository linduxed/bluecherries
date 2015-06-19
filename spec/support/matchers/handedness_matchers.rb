RSpec::Matchers.define :have_key_count_on_each_row do |key_count|
  match do |layout|
    one_hand_keys = layout.keys.select { |key| key.hand == @hand }
    rows = one_hand_keys.group_by(&:row_number).values

    rows.all? { |row| row.length == key_count }
  end

  chain :on_hand do |hand|
    @hand = hand
  end
end
