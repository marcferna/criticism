module Criticism

  class Feed::Page::Entry::Author

    attr_reader :name, :uri

    def initialize(name:, uri:)
      @name = name
      @uri = uri
    end

  end

end
