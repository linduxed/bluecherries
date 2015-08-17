require 'spec_helper'

module BlueCherries
  describe MotionGenerator do
    describe '#left_hand_motions' do
      it 'returns motions only comprised from left hand keys' do
        layout = double(:layout, keys: layout_keys)

        generated_motions = MotionGenerator.new(layout).left_hand_motions

        letters_of_all_motions = generated_motions.map(&:to_s).map(&:chars).
          flatten.uniq
        expect(letters_of_all_motions).to include(
          *%w(q w e r t a s d f g z x c v b)
        )
        expect(letters_of_all_motions).not_to include(
          *%w(y u i o p h j k l n m)
        )
      end

      it 'returns all one letter sequences' do
        layout = double(:layout, keys: layout_keys)
        one_letter_sequences = %w(q w e r t a s d f g z x c v b)

        generated_motions = MotionGenerator.new(layout).left_hand_motions

        generated_motions_as_letters = generated_motions.map(&:to_s)
        expect(generated_motions_as_letters).to include(*one_letter_sequences)
      end

      it 'returns all two letter sequences' do
        layout = double(:layout, keys: layout_keys)
        same_row_adjacent_right = %w(qw we er rt as sd df fg zx xc cv vb)
        same_row_adjacent_left = %w(wq ew re tr sa ds fd gf xz cx vc bv)
        same_row_one_space_right = %w(qe wr et ad sf dg zc xv cb)
        same_row_one_space_left = %w(eq rw te da fs gd cz vx bc)
        same_row_two_spaces_right = %w(qr wt af sg zv xb)
        same_row_two_spaces_left = %w(rq tw fa gs vz bx)
        same_row_three_spaces_right = %w(qt ag zb)
        same_row_three_spaces_left = %w(tq ga bz)
        two_rows_same_column_right = %w(ed rf tg sx dc fv gb)
        two_rows_same_column_left = %w(de fr gt xs cd vf bg)
        two_rows_adjacent_right = %w(aw se dr zs xd cf)
        two_rows_adjacent_left = %w(wa es rd sz dx fc)
        two_rows_one_space_right = %w(ae sr dt zd xf cg)
        two_rows_one_space_left = %w(ea rs td dz fx gc)
        forbidden_motions = %w(zq zw ze xq xw xe xr cr qz qx yu jk op mn hj iu
          ft aq az za vg)

        generated_motions = MotionGenerator.new(layout).left_hand_motions

        generated_motions_as_letters = generated_motions.map(&:to_s)
        [
          same_row_adjacent_right,
          same_row_adjacent_left,
          same_row_one_space_right,
          same_row_one_space_left,
          same_row_two_spaces_right,
          same_row_two_spaces_left,
          same_row_three_spaces_right,
          same_row_three_spaces_left,
          two_rows_same_column_right,
          two_rows_same_column_left,
          two_rows_adjacent_right,
          two_rows_adjacent_left,
          two_rows_one_space_right,
          two_rows_one_space_left
        ].each do |expected_motions|
          expect(generated_motions_as_letters).to(
            include(*expected_motions),
            "Generated motions: #{generated_motions_as_letters}\n" \
              "Expected motions: #{expected_motions}\n" \
              'Missing motions: ' \
              "#{expected_motions - generated_motions_as_letters}"
          )
        end
        expect(generated_motions_as_letters).not_to(
          include(*forbidden_motions),
          "Generated motions: #{generated_motions_as_letters}\n" \
            "Forbidden motions: #{forbidden_motions}\n" \
            'Forbidden found: ' \
            "#{forbidden_motions & generated_motions_as_letters}"
        )
      end

      it 'returns all three letter sequences'

      it 'returns all four letter sequences'
    end

    describe '#right_hand_motions' do
      it 'returns motions only comprised from right hand keys' do
        layout = double(:layout, keys: layout_keys)

        generated_motions = MotionGenerator.new(layout).right_hand_motions

        letters_of_all_motions = generated_motions.map(&:to_s).map(&:chars).
          flatten.uniq
        expect(letters_of_all_motions).to include(
          *%w(y u i o p h j k l n m)
        )
        expect(letters_of_all_motions).not_to include(
          *%w(q w e r t a s d f g z x c v b)
        )
      end

      it 'returns all one letter sequences' do
        layout = double(:layout, keys: layout_keys)

        generated_motions = MotionGenerator.new(layout).right_hand_motions

        generated_motions_as_letters = generated_motions.map(&:to_s)
        expect(generated_motions_as_letters).to include(
          *%w(y u i o p h j k l n m)
        )
      end

      it 'returns all two letter sequences' do
        layout = double(:layout, keys: layout_keys)
        same_row_adjacent_right = %w(yu ui io op hj jk kl nm)
        same_row_adjacent_left = %w(po oi iu uy lk kj jh mn)
        same_row_one_space_right = %w(yi uo ip hk jl)
        same_row_one_space_left = %w(iy ou pi kh lj)
        same_row_two_spaces_right = %w(yo up hl)
        same_row_two_spaces_left = %w(oy pu lh)
        same_row_three_spaces_right = %w(yp)
        same_row_three_spaces_left = %w(py)
        two_rows_adjacent_right = %w(hu ji ko lp nj mk)
        two_rows_adjacent_left = %w(uh ij ok pl jn km)
        two_rows_one_space_right = %w(hi jo kp nk ml yk ul)
        two_rows_one_space_left = %w(ih oj pk kn lm pk oj ih)
        forbidden_motions = %w(yn ny um mu yh hy nh hn ju uj jm mj jy yj uk ku
          li il)

        generated_motions = MotionGenerator.new(layout).right_hand_motions

        generated_motions_as_letters = generated_motions.map(&:to_s)
        [
          same_row_adjacent_right,
          same_row_adjacent_left,
          same_row_one_space_right,
          same_row_one_space_left,
          same_row_two_spaces_right,
          same_row_two_spaces_left,
          same_row_three_spaces_right,
          same_row_three_spaces_left,
          two_rows_adjacent_right,
          two_rows_adjacent_left,
          two_rows_one_space_right,
          two_rows_one_space_left
        ].each do |expected_motions|
          expect(generated_motions_as_letters).to(
            include(*expected_motions),
            "Generated motions: #{generated_motions_as_letters}\n" \
              "Expected motions: #{expected_motions}\n" \
              'Missing motions: ' \
              "#{expected_motions - generated_motions_as_letters}"
          )
        end
        expect(generated_motions_as_letters).not_to(
          include(*forbidden_motions),
          "Generated motions: #{generated_motions_as_letters}\n" \
            "Forbidden motions: #{forbidden_motions}\n" \
            'Forbidden found: ' \
            "#{forbidden_motions & generated_motions_as_letters}"
        )
      end

      it 'returns all three letter sequences'

      it 'returns all four letter sequences'
    end

    def layout_keys
      [
        double(char: 'q', row: 0, column: 0),
        double(char: 'w', row: 0, column: 1),
        double(char: 'e', row: 0, column: 2),
        double(char: 'r', row: 0, column: 3),
        double(char: 't', row: 0, column: 4),
        double(char: 'y', row: 0, column: 5),
        double(char: 'u', row: 0, column: 6),
        double(char: 'i', row: 0, column: 7),
        double(char: 'o', row: 0, column: 8),
        double(char: 'p', row: 0, column: 9),
        double(char: 'a', row: 1, column: 0),
        double(char: 's', row: 1, column: 1),
        double(char: 'd', row: 1, column: 2),
        double(char: 'f', row: 1, column: 3),
        double(char: 'g', row: 1, column: 4),
        double(char: 'h', row: 1, column: 5),
        double(char: 'j', row: 1, column: 6),
        double(char: 'k', row: 1, column: 7),
        double(char: 'l', row: 1, column: 8),
        double(char: 'z', row: 2, column: 0),
        double(char: 'x', row: 2, column: 1),
        double(char: 'c', row: 2, column: 2),
        double(char: 'v', row: 2, column: 3),
        double(char: 'b', row: 2, column: 4),
        double(char: 'n', row: 2, column: 5),
        double(char: 'm', row: 2, column: 6)
      ]
    end
  end
end
