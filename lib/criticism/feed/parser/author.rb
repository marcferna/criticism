module Criticism
  class Feed
    class Parser
      class Author
        require 'nokogiri'

        attr_reader :name, :uri

        def initialize(author_xml)
          @author_xml = author_xml
          @name = parse_name
          @uri = parse_uri
        end

        private

        def parse_name
          @author_xml.xpath('./name').first.content
        end

        def parse_uri
          @author_xml.xpath('./uri').first.content
        end
      end
    end
  end
end
