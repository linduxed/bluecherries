require 'spec_helper'

module BlueCherries
  describe AlgorithmFinder do
    describe '#find' do
      it 'finds an algorithm that corresponds to the provided name' do
        class FoobarAlgorithm; end
        name = 'foobar'
        algorithm_list = {
          'foobar' => FoobarAlgorithm
        }

        algorithm = AlgorithmFinder.new(name,
          algorithm_list: algorithm_list).find

        expect(algorithm).to eq(FoobarAlgorithm)

        BlueCherries.send(:remove_const, :FoobarAlgorithm)
      end

      it 'writes an error message if an algorithm is not found' do
        with_stubbed_stderr do
          name = 'some_non_existent_algorithm'

          expect { AlgorithmFinder.new(name).find }.to terminate.with_code(64)
          expect($stderr.string).to have_error_message(
            "there is no \"#{name}\" algorithm")
        end
      end
    end
  end
end
