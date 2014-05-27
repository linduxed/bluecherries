module BlueCherries
  class AlgorithmNotFound < StandardError; end

  class AlgorithmFinder
    ALGORITHMS = {
      'head' => HeadAlgorithm,
      'random' => RandomAlgorithm
    }.freeze

    def self.default_instance
      @default_instance = new('default', algorithm_list: ALGORITHMS) unless @default_instance
      @default_instance
    end

    def initialize(name, options = {})
      @name = name
      @algorithm_list = options.fetch(:algorithm_list, ALGORITHMS)
    end

    def find
      algorithm_list.fetch(name) do
        $stderr.puts "Available algorithms are: #{available_algorithms.join(', ')}"
        fail AlgorithmNotFound, "There is no \"#{name}\" algorithm."
      end
    end

    def available_algorithms
      algorithm_list.keys
    end

    private
    attr_reader :name, :algorithm_list
  end
end
