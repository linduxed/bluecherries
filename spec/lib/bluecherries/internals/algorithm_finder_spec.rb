require 'spec_helper'

module BlueCherries
  describe AlgorithmFinder do
    describe '#find' do
      it 'finds an algorithm that corresponds to the provided name' do
        foobar_algorithm = double('foobar_algorithm')
        algorithm_list = {
          foobar: foobar_algorithm
        }

        algorithm = AlgorithmFinder.new(algorithm_list).find(:foobar)

        expect(algorithm).to eq(foobar_algorithm)
      end

      it 'writes an error message if an algorithm is not found' do
        with_stubbed_stderr do
          expect { AlgorithmFinder.find(:some_non_existent_algorithm) }.to raise_error(AlgorithmNotFound)
          expect($stderr.string).to match(/available algorithms/i)
        end
      end
    end
  end
end
