module Criticism
  class Feed::Parser
    require 'nokogiri'
    require 'open-uri'

    attr_reader :previous_url, :next_url, :entries

    def initialize(url)
      @document = Nokogiri::XML(open(url)).remove_namespaces!
      @previous_url = @document.xpath("/feed/link[@rel='previous']").first['href']
      @next_url = @document.xpath("/feed/link[@rel='next']").first['href']
      @entries = parse_entries
    end

  private

    def parse_entries
      entries = []
      @document.xpath("/feed/entry").each_with_index do |entry, index|
        next if index == 0
        entries << Criticism::Feed::Page::Entry.new(
          id:      entry.xpath("./id").first.content,
          title:   entry.xpath("./title").first.content,
          review:  (entry.xpath("./content").first.content rescue ''),
          rating:  entry.xpath("./rating").first.content,
          version: entry.xpath("./version").first.content,
          author:  parse_author(entry),
        )
      end
      entries
    end

    def parse_author(entry_xml)
      Criticism::Feed::Page::Entry::Author.new(
        name: entry_xml.xpath("./author/name").first.content,
        uri:  entry_xml.xpath("./author/uri").first.content
      )
    end
  end
end
