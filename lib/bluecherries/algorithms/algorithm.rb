module BlueCherries
  # Base class which all algorithms inherit from.
  class Algorithm
    def self.names_of_all_algorithms
      descendants.map(&:name)
    end

    def self.name
      to_s.gsub(/BlueCherries::/, '').gsub(/Algorithm/, '').downcase
    end
  end
end
