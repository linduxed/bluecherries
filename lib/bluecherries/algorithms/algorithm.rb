module BlueCherries
  class Algorithm
    def self.names_of_all_algorithms
      descendants.map(&:name)
    end

    def self.name
      to_s.gsub(/BlueCherries::/, '').gsub(/Algorithm/, '').downcase
    end
  end
end
