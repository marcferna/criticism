require 'spec_helper'

describe Criticism::Feed::Page do
  describe '#new' do
    let(:page) { Criticism::Feed::Page.new('./spec/fixtures/feed_file.xml') }

    it 'sets the entries' do
      expect(page.entries).to_not be_nil
    end

    it 'parses the next page' do
      expect(page.next).to be_a(described_class)
    end

    it 'parses the previous page' do
      expect(page.previous).to be_a(described_class)
    end
  end
end
