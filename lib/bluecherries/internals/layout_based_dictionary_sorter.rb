module BlueCherries
  class LayoutBasedDictionarySorter
    def initialize(dictionary, layout)
      @dictionary = dictionary
      @layout = layout
    end

    def sort
      []
    end

    private

    attr_reader :dictionary, :layout
  end
end
