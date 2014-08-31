require 'spec_helper'

describe Class do
  describe '#descendants' do
    it 'returns a list of classes that inherit from the callee' do
      class ParentClass; end
      class FirstChild < ParentClass; end
      class SecondChild < ParentClass; end

      expect(ParentClass.descendants).to include(FirstChild, SecondChild)

      Object.send(:remove_const, :ParentClass)
      Object.send(:remove_const, :FirstChild)
      Object.send(:remove_const, :SecondChild)
    end
  end
end
