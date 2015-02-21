module BlueCherries
  class Layout
    def initialize(path = 'qwerty')
      @path = path
    end

    def left_hand_motions
      []
    end

    private

    attr_reader :path
  end
end
