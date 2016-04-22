module Criticism
  class Feed
    class Parser
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
          entries << parse_entry(entry_xml)
        end
        entries
      end

      def parse_entry(entry_xml)
        entry_parser = Criticism::Feed::Parser::Entry.new(entry_xml)
        entry = Criticism::Feed::Page::Entry.new(
          id:      entry_parser.id,
          title:   entry_parser.title,
          review:  entry_parser.review,
          rating:  entry_parser.rating,
          version: entry_parser.version
        )
        entry.author = parse_author(entry_xml.xpath('./author'))
        entry
      end

      def parse_author(author_xml)
        author_parser = Criticism::Feed::Parser::Author.new(author_xml)
        Criticism::Feed::Page::Entry::Author.new(
          name: author_parser.name,
          uri:  author_parser.uri
        )
      end
    end
  end
end
