module Criticism
  class Feed
    class Parser
      class Entry
        require 'nokogiri'

        attr_reader :id, :title, :review, :rating, :version

        def initialize(entry_xml)
          @entry_xml = entry_xml
          @id = parse_id
          @title = parse_title
          @review = parse_review
          @rating = parse_rating
          @version = parse_version
        end

        private

        def parse_id
          @entry_xml.xpath('./id').first.content
        end

        def parse_title
          @entry_xml.xpath('./title').first.content
        end

        def parse_review
          @entry_xml.xpath('./content').first.content
        end

        def parse_rating
          @entry_xml.xpath('./rating').first.content
        rescue
          ''
        end

        def parse_version
          @entry_xml.xpath('./version').first.content
        end
      end
    end
  end
end
