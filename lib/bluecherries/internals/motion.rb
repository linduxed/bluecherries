module BlueCherries
  class Motion
    attr_reader :keys

    def initialize(keys)
      @keys = keys
    end

    def chars
      keys.map(&:char).join
    end

    def ==(other)
      other.keys == keys
    end
  end
end
