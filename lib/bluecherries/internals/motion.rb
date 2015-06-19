module BlueCherries
  class Motion
    attr_reader :keys

    def initialize(keys)
      @keys = keys
    end

    def chars
      keys.map { |key| key.char }.join
    end

    def ==(motion)
      motion.keys == keys
    end
  end
end
