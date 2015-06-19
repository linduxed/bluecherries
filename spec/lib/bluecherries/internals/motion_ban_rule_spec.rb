require 'spec_helper'

module BlueCherries
  describe MotionBanRule do
    it 'raises an error if instantiated without a block' do
      expect do
        MotionBanRule.new
      end.to raise_error(NoBlockGiven)
    end

    describe '#banned_motion?' do
      context 'rule in block disallows motions with keys in the same column' do
        context 'motion has a sequence of keys in the same column' do
          it 'returns true' do
            ban_rule = MotionBanRule.new do
              iterate_over_keys_in_motion_with_index do |current_key, _|
                motion_banned if current_key.column == next_key.column
              end
            end
            w_key = double(:w_key, column: 1)
            s_key = double(:s_key, column: 1)
            d_key = double(:d_key, column: 2)
            motion = double(:motion, keys: [w_key, s_key, d_key])

            banned = ban_rule.banned_motion?(motion)

            expect(banned).to be_truthy
          end
        end
      end

      context 'rule in block disallows motions with keys in the same row' do
        context 'motion has a sequence of keys in the same row' do
          it 'returns true' do
            ban_rule = MotionBanRule.new do
              iterate_over_keys_in_motion_with_index do |current_key, _|
                motion_banned if current_key.row == next_key.row
              end
            end
            w_key = double(:w_key, row: 0)
            s_key = double(:s_key, row: 1)
            d_key = double(:d_key, row: 1)
            motion = double(:motion, keys: [w_key, s_key, d_key])

            banned = ban_rule.banned_motion?(motion)

            expect(banned).to be_truthy
          end
        end
      end

      context 'rule in block disallows motions with keys in the same row' do
        context 'motion has no sequence of keys in the same row' do
          it 'returns true' do
            ban_rule = MotionBanRule.new do
              iterate_over_keys_in_motion_with_index do |current_key, _|
                motion_banned if current_key.row == next_key.row
              end
            end
            w_key = double(:w_key, row: 0)
            s_key = double(:s_key, row: 1)
            x_key = double(:x_key, row: 2)
            motion = double(:motion, keys: [w_key, s_key, x_key])

            banned = ban_rule.banned_motion?(motion)

            expect(banned).to be_falsy
          end
        end
      end
    end
  end
end
