require 'spec_helper'
require 'bluecherries/internals/motion'

module BlueCherries
  describe MotionGenerator do
    describe '#left_hand' do
      it 'returns motions only comprised from left hand keys' do
        q_key = double(char: 'q')
        w_key = double(char: 'w')
        e_key = double(char: 'e')
        r_key = double(char: 'r')
        t_key = double(char: 't')
        y_key = double(char: 'y')
        u_key = double(char: 'u')
        i_key = double(char: 'i')
        o_key = double(char: 'o')
        p_key = double(char: 'p')
        key_rows = [
          [q_key, w_key, e_key, r_key, t_key, y_key, u_key, i_key, o_key,
            p_key]
        ]
        q = Motion.new([q_key])
        w = Motion.new([w_key])
        e = Motion.new([e_key])
        r = Motion.new([r_key])
        t = Motion.new([t_key])
        y = Motion.new([y_key])
        u = Motion.new([u_key])
        i = Motion.new([i_key])
        o = Motion.new([o_key])
        p = Motion.new([p_key])

        generated_motions = MotionGenerator.new(key_rows, 1).left_hand

        expect(generated_motions).to include(q, w, e, r, t)
        expect(generated_motions).not_to include(y, u, i, o, p)
      end
    end

    describe '#right_hand' do
      it 'returns motions only comprised from right hand keys' do
        q_key = double(char: 'q')
        w_key = double(char: 'w')
        e_key = double(char: 'e')
        r_key = double(char: 'r')
        t_key = double(char: 't')
        y_key = double(char: 'y')
        u_key = double(char: 'u')
        i_key = double(char: 'i')
        o_key = double(char: 'o')
        p_key = double(char: 'p')
        key_rows = [
          [q_key, w_key, e_key, r_key, t_key, y_key, u_key, i_key, o_key,
            p_key]
        ]
        q = Motion.new([q_key])
        w = Motion.new([w_key])
        e = Motion.new([e_key])
        r = Motion.new([r_key])
        t = Motion.new([t_key])
        y = Motion.new([y_key])
        u = Motion.new([u_key])
        i = Motion.new([i_key])
        o = Motion.new([o_key])
        p = Motion.new([p_key])

        generated_motions = MotionGenerator.new(key_rows, 1).right_hand

        expect(generated_motions).to include(y, u, i, o, p)
        expect(generated_motions).not_to include(q, w, e, r, t)
      end
    end
  end
end
