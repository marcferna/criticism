module Criticism
  class Ios
    class Feed
      class Parser
        class Author
          require 'nokogiri'

          attr_reader :author

          def initialize(author_xml)
            @author_xml = author_xml
            @author = Criticism::Author.new(
              name: name,
              uri:  uri
            )
          end

          private

          def name
            @author_xml.xpath('./name').first.content
          end

          def uri
            @author_xml.xpath('./uri').first.content
          end
        end
      end
    end
  end
end
