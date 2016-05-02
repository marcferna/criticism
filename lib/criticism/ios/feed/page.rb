module Criticism
  class Ios
    class Feed
      class Page
        attr_reader :entries

        def initialize(url)
          @parser = Criticism::Ios::Feed::Parser::Page.new(url)
          @entries = @parser.entries
        end

        def previous
          @previous ||= self.class.new(@parser.previous_url)
        end

        def next
          @next ||= self.class.new(@parser.next_url)
        end
      end
    end
  end
end
