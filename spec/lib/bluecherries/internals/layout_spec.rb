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
        one_letter_sequences = %w[ q w e r t a s d f g z x c v b ]
        forbidden_sequences = %w[ y u i o p h j k l n m ]

        list_of_motions = Layout.new('qwerty').left_hand_motions

        expect(list_of_motions).to include(*one_letter_sequences)
        expect(list_of_motions).not_to include(*forbidden_sequences)
      end

      it 'returns all two letter sequences' do
        same_row_adjacent = %w[ qw we er rt as sd df fg zx xc cv vb ]
        same_row_not_adjacent = %w[ qe wr et eq rw te ad af sf fs da zc xv bc ]
        two_adjacent_rows = %w[ aw ae rs wf se dr xf vd qf ]
        sample_two_letter_sequences = same_row_adjacent +
          same_row_not_adjacent + two_adjacent_rows
        sample_forbidden_sequences = %w[ zq zw ze xq xw xe xr cr qz qx qb bq yu
          jk op mn hj iu ]

        list_of_motions = Layout.new('qwerty').left_hand_motions

        expect(list_of_motions).to include(*sample_two_letter_sequences)
        expect(list_of_motions).not_to include(*sample_forbidden_sequences)
      end

      it 'returns all three letter sequences' do
        three_letter_sequences = %w[ sdf fds lkj jkl aer liu adv poi ]

        list_of_motions = Layout.new('qwerty').left_hand_motions

        expect(list_of_motions).to include(*three_letter_sequences)
      end

      it 'returns all four letter sequences' do
        four_letter_sequences = %w[ asdf fdsa qwer awer zsdf ]

        list_of_motions = Layout.new('qwerty').left_hand_motions

        expect(list_of_motions).to include(*four_letter_sequences)
      end
    end
  end
end
