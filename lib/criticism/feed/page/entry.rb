module Criticism

  class Feed::Page::Entry

    attr_reader :id, :title, :review, :rating, :version, :author

    def initialize(id:, title:, review:, rating:, version:, author:)
      @id = id
      @title = title
      @review = review
      @rating = rating
      @version = version
      @author = author
    end
  end

end
