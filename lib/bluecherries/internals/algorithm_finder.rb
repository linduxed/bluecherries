module BlueCherries
  class AlgorithmNotFound < StandardError; end

  class AlgorithmFinder

    def self.default_instance
      @default_instance = new(DEFAULT_ALGORITHMS) unless @default_instance
      @default_instance
    end

    def self.find(name)
      default_instance.find(name)
    end

    def initialize(algorithm_list = nil)
      @algorithm_list = algorithm_list || DEFAULT_ALGORITHMS
    end

    def find(name)
      algorithm_list.fetch(name) do
        $stderr.puts "Available algorithms are: #{available_algorithms.join(', ')}"
        fail AlgorithmNotFound, "There is no \"#{name}\" algorithm."
      end
    end

    def available_algorithms
      algorithm_list.keys
    end

    private

    DEFAULT_ALGORITHMS = {
      head: HeadAlgorithm,
      random: RandomAlgorithm
    }.freeze

    attr_reader :algorithm_list
  end
end
