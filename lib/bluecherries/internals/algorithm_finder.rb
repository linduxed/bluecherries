module BlueCherries
  class AlgorithmNotFound < StandardError; end

  class AlgorithmFinder
    ALGORITHMS = {
      'head' => HeadAlgorithm,
      'random' => RandomAlgorithm
    }.freeze

    def self.names_of_available_algorithms
      ALGORITHMS.keys
    end

    def initialize(name, options = {})
      @name = name
      @algorithm_list = options.fetch(:algorithm_list, ALGORITHMS)
    end

    def find
      algorithm_list.fetch(name) do
        $stderr.puts "Available algorithms are: #{available_algorithms}"
        fail AlgorithmNotFound, "There is no \"#{name}\" algorithm."
      end
    end

    private

    attr_reader :name, :algorithm_list

    def available_algorithms
      algorithm_list.keys.join(', ')
    end
  end
end
