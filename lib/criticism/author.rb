module Criticism
  class Author
    attr_reader :name, :uri
    def initialize(name:, uri:)
      @name = name
      @uri = uri
    end
  end
end
