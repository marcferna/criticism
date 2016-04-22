module Criticism
  class Feed
    attr_reader :app_id, :country, :language, :page

    def initialize(app_id:, country: 'us', language: 'en')
      @app_id = app_id
      @country = country
      @language = language
      @page = Criticism::Feed::Page.new(url)
    end

    private

    def url
      "https://itunes.apple.com/#{country}/rss/customerreviews/id=#{app_id}/"\
      "sortBy=mostRecent/xml?l=#{language}"
    end
  end
end
