module BlueCherries
  class AlgorithmNotFound < StandardError; end

  class AlgorithmFinder
    def initialize(name, options = {})
      @name = name
      @algorithm_list = options.fetch(:algorithm_list, Algorithm.descendants)
    end

    def find
      if found = find_name_in_algorithm_list
        found
      else
        algorithm_not_found
      end
    end

    private

    attr_reader :name, :algorithm_list

    def find_name_in_algorithm_list
      algorithm_list.detect do |algorithm|
        algorithm.name == name
      end
    end

    def algorithm_not_found
      fail(
        AlgorithmNotFound,
        "There is no \"#{name}\" algorithm.\n" +
        "Available algorithms are: #{available_algorithms}"
      )
    end

    def available_algorithms
      algorithm_list.map(&:name).join(', ')
    end
  end
end
