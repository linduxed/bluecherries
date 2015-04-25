module BlueCherries
  class Motion
    def initialize(keys)
      @keys = keys
    end

    def chars
      keys.map { |key| key.char }.join
    end

    private

    attr_reader :keys
  end
end
