require 'spec_helper'

module BlueCherries
  describe AlgorithmFinder do
    describe '#find' do
      it 'finds an algorithm that corresponds to the provided name' do
        name = 'foobar'
        foobar_algorithm = double('foobar_algorithm', name: 'foobar')
        algorithm_list = [foobar_algorithm]

        algorithm = AlgorithmFinder.new(name,
          algorithm_list: algorithm_list).find

        expect(algorithm).to eq(foobar_algorithm)
      end

      it 'writes an error message if an algorithm is not found' do
        non_existent_algorithm_name = 'some_non_existent_algorithm'

        expect do
          AlgorithmFinder.new(non_existent_algorithm_name).find
        end.to raise_error(AlgorithmNotFound, /[Aa]vailable algorithms/)
      end
    end
  end
end
