module Criticism
  class Feed::Page

    attr_reader :entries

    def initialize(url)
      @parser = Criticism::Feed::Parser.new(url)
      @entries = @parser.entries
    end

    def previous
      @previous ||= Feed::Page.new(@parser.previous_url)
    end

    def next
      @next ||= Feed::Page.new(@parser.next_url)
    end
  end
end
