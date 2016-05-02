module Criticism
  class Ios
    def initialize(app_id:, country: 'us', language: 'en')
      @feed = Criticism::Ios::Feed.new(
        app_id:   app_id,
        country:  country,
        language: language
      )
      @page = @feed.page
    end

    def reviews
      @page.entries
    end

    def next
      @page = @page.next
      self
    end

    def previous
      @page = @page.previous
      self
    end
  end
end
