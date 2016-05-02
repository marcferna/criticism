module Criticism
  class Android
    class Cloud
      class File
        require 'csv'

        attr_accessor :reviews

        def initialize(file:)
          @file = file
          @reviews = parse_reviews
        end

        private

        attr_reader :file

        def parse_reviews
          reviews = []
          unless file.nil?
            CSV.foreach(file, csv_options) do |row|
              row = Row.new(row: row)
              reviews << row.review if row.review?
            end
          end
          reviews
        end

        def csv_options
          {
            encoding:          'bom|UTF-16LE',
            headers:           true,
            header_converters: :symbol
          }
        end
      end
    end
  end
end
