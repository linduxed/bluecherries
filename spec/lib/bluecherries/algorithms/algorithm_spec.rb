require 'spec_helper'

module BlueCherries
  describe Algorithm do
    describe '.names_of_all_algorithms' do
      it 'returns a list of all algorithm names' do
        foo_alg = double(name: 'foo')
        bar_alg = double(name: 'bar')
        baz_alg = double(name: 'baz')
        allow(Algorithm).to receive(:descendants).and_return(
          [foo_alg, bar_alg, baz_alg])

        names = Algorithm.names_of_all_algorithms

        expect(names).to match_array(%w(foo bar baz))
      end
    end

    describe '#name' do
      it 'returns algorithm name' do
        class FoobarAlgorithm < Algorithm; end

        child_class_name = FoobarAlgorithm.name
        base_class_name = Algorithm.name

        expect(child_class_name).to match(/foobar/)
        expect(base_class_name).to eq('')

        BlueCherries.send(:remove_const, :FoobarAlgorithm)
      end

      it 'does not include module prefix or "Algorithm" suffix in the name' do
        class FoobarAlgorithm < Algorithm; end

        child_class_name = FoobarAlgorithm.name

        expect(child_class_name).not_to match(/BlueCherries/i)
        expect(child_class_name).not_to match(/::/)
        expect(child_class_name).not_to match(/algorithm/i)

        BlueCherries.send(:remove_const, :FoobarAlgorithm)
      end
    end
  end
end
