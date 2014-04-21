module BlueCherries
  class AlgorithmFinder
    def initialize(name)
      @name = name
    end

    def find
      eval(titleized_name + 'Algorithm')
    rescue NameError
      $stderr.puts "ERROR: there is no \"#{name}\" algorithm"
      exit 64
    end

    private

    attr_reader :name

    def titleized_name
      name[0].upcase + name[1..-1].downcase
    end
  end
end
