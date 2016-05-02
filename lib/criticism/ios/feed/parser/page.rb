module Criticism
  class Ios
    class Feed
      class Parser
        class Page
          require 'nokogiri'
          require 'open-uri'

          attr_reader :previous_url, :next_url, :entries

          def initialize(url)
            @document = Nokogiri::XML(open(url)).remove_namespaces!
            @previous_url = @document.xpath(
              "/feed/link[@rel='previous']"
            ).first['href']
            @next_url = @document.xpath("/feed/link[@rel='next']").first['href']
            @entries = parse_entries
          end

          private

          def parse_entries
            entries = []
            @document.xpath('/feed/entry').each_with_index do |entry_xml, index|
              next if index == 0
              entries << Criticism::Ios::Feed::Parser::Review.new(
                entry_xml
              ).review
            end
            entries
          end
        end
      end
    end
  end
end
