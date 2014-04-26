module BlueCherries
  class AlgorithmFinder
    ALGORITHMS = {
      'head' => HeadAlgorithm,
      'random' => RandomAlgorithm
    }.freeze

    def initialize(name, options = {})
      @name = name
      @algorithm_list = options.fetch(:algorithm_list, ALGORITHMS)
    end

    def find
      algorithm_list.fetch(name) do
        $stderr.puts "ERROR: there is no \"#{name}\" algorithm"
        exit 64
      end
    end

    private

    attr_reader :name, :algorithm_list
  end
end
