require 'spec_helper'

module BlueCherries
  describe AlgorithmFinder do
    describe '#find' do
      it 'finds an algorithm that corresponds to the provided name' do
        name = 'foobar'
        foobar_algorithm = double('foobar_algorithm')
        algorithm_list = {
          'foobar' => foobar_algorithm
        }

        algorithm = AlgorithmFinder.new(name,
          algorithm_list: algorithm_list).find

        expect(algorithm).to eq(foobar_algorithm)
      end

      it 'writes an error message if an algorithm is not found' do
        with_stubbed_stderr do
          non_existent_algorithm_name = 'some_non_existent_algorithm'

          expect do
            AlgorithmFinder.new(non_existent_algorithm_name).find
          end.to terminate.with_code(64)
          expect($stderr.string).to have_error_message(
            "there is no \"#{non_existent_algorithm_name}\" algorithm")
          expect($stderr.string).to match(/[Aa]vailable algorithms/)
        end
      end
    end
  end
end
