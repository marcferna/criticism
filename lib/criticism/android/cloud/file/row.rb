module Criticism
  class Android
    class Cloud
      class File
        class Row
          attr_reader :review

          def initialize(row:)
            @row = row
            @review = Criticism::Review.new(
              id:      id,
              title:   row[:review_title],
              review:  row[:review_text],
              rating:  row[:star_rating],
              version: row[:app_version_name]
            )
          end

          def review?
            !row[:review_link].nil?
          end

          private

          attr_reader :row

          def id
            unless row[:review_link].nil?
              link = row[:review_link].force_encoding(Encoding::UTF_8)
              match = /^.*reviewid=gp:(?<id>.*)$/.match(link)
              match[:id] unless match.nil?
            end
          end
        end
      end
    end
  end
end
