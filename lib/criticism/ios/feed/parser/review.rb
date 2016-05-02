module Criticism
  class Ios
    class Feed
      class Parser
        class Review
          require 'nokogiri'

          attr_reader :review

          def initialize(entry_xml)
            @entry_xml = entry_xml
            @review = parsed_review
            @review.author = parsed_author
          end

          private

          def parsed_review
            Criticism::Review.new(
              id:      id,
              title:   title,
              review:  review_text,
              rating:  rating,
              version: version
            )
          end

          def parsed_author
            Criticism::Ios::Feed::Parser::Author.new(
              @entry_xml.xpath('./author')
            ).author
          end

          def id
            @entry_xml.xpath('./id').first.content
          end

          def title
            @entry_xml.xpath('./title').first.content
          rescue
            ''
          end

          def review_text
            @entry_xml.xpath("./content[@type='text']").first.content
          rescue
            ''
          end

          def rating
            @entry_xml.xpath('./rating').first.content
          rescue
            ''
          end

          def version
            @entry_xml.xpath('./version').first.content
          end
        end
      end
    end
  end
end
