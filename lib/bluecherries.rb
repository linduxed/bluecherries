require "bluecherries/version"

module BlueCherries
  class Layout
    def initialize(layout = :qwerty)
      begin
        layout_file = File.open layout_path(layout.to_s)
      rescue Errno::ENOENT
        puts "ERROR: The layout file for #{layout.to_s.upcase} doesn't exist."
        exit
      end

      @keys = layout_file.readlines.map(&:chomp)
    end

    private

    attr_reader :keys, :layout

    def layout_path(name)
      File.expand_path("../../layouts/#{name}.layout", __FILE__)
    end
  end
end
