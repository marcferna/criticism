module Criticism
  class Review
    attr_reader :id, :title, :text, :rating, :version
    attr_accessor :author

    def initialize(id:, title:, text:, rating:, version:)
      @id = id
      @title = title
      @text = text
      @rating = rating
      @version = version
      @author = author
    end
  end
end
