module Criticism
  class Review
    attr_reader :id, :title, :review, :rating, :version
    attr_accessor :author

    def initialize(id:, title:, review:, rating:, version:)
      @id = id
      @title = title
      @review = review
      @rating = rating
      @version = version
      @author = author
    end
  end
end
