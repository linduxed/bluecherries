require 'spec_helper'

module BlueCherries
  describe Layout do
    describe '.new' do
      it 'has default values' do
        expect { Layout.new }.not_to raise_error
      end
    end

    it 'raises an error if a malformed layout is provided' do
      file = Tempfile.new 'layout_file'
      file.write("qw\nasdf\nz")
      file.close

      expect { Layout.new(file.path).left_hand_motions }.to raise_error(
        BadLayoutError)
    end

    it 'raises an error if an empty layout is provided' do
      file = Tempfile.new 'layout_file'
      file.close

      expect { Layout.new(file.path).left_hand_motions }.to raise_error(
        BadLayoutError)
    end

    context 'a path to a non-existant dictionary was provided' do
      it 'raises an error' do
        expect { Layout.new('foo.bar.baz').left_hand_motions }.to raise_error(
          MissingLayoutError)
      end
    end

    describe '#left_hand_motions' do
      it 'returns all one letter sequences' do
        one_letter_sequences = %w(q w e r t a s d f g z x c v b)
        forbidden_sequences = %w(y u i o p h j k l n m)

        generated_motions = Layout.new('qwerty').left_hand_motions
        generated_motions_as_letters = generated_motions.
          map { |motion| motion.chars }

        expect(generated_motions_as_letters).to include(*one_letter_sequences)
        expect(generated_motions_as_letters).not_to include(
          *forbidden_sequences)
      end

      it 'returns all two letter sequences' do
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

        generated_motions = Layout.new('qwerty').left_hand_motions
        generated_motions_as_letters = generated_motions.
          map { |motion| motion.chars }

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
          two_rows_one_space_left,
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

      it 'returns all three letter sequences' do
        pending
        three_letter_sequences = %w(sdf fds lkj jkl aer liu adv poi)

        generated_motions = Layout.new('qwerty').left_hand_motions

        expect(generated_motions).to include(*three_letter_sequences)
      end

      it 'returns all four letter sequences' do
        pending
        four_letter_sequences = %w(asdf fdsa qwer awer zsdf)

        generated_motions = Layout.new('qwerty').left_hand_motions

        expect(generated_motions).to include(*four_letter_sequences)
      end
    end
  end
end
