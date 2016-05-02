require 'spec_helper'

describe Criticism::Ios::Feed::Page do
  describe '#new' do
    let(:page) do
      Criticism::Ios::Feed::Page.new('./spec/fixtures/ios/feed_file.xml')
    end

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
