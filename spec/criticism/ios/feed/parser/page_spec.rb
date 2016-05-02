require 'spec_helper'

describe Criticism::Ios::Feed::Parser::Page do
  describe '#new' do
    let(:parser) do
      Criticism::Ios::Feed::Parser::Page.new(
        './spec/fixtures/ios/feed_file.xml'
      )
    end

    it 'sets the previous url' do
      expect(parser.previous_url).to eq(
        'https://itunes.apple.com/us/rss/customerreviews/page=1/id=123456/'\
        'sortby=mostrecent/xml?l=en=/customerreviews/id=123456/sortBy='\
        'mostRecent/xml'
      )
    end

    it 'sets the next url' do
      expect(parser.next_url).to eq(
        'https://itunes.apple.com/us/rss/customerreviews/page=2/id=123456/'\
        'sortby=mostrecent/xml?l=en=/customerreviews/id=123456/sortBy='\
        'mostRecent/xml'
      )
    end

    context 'entries parsing' do
      let(:first_entry) { parser.entries.first }
      it 'parses all the entries' do
        expect(parser.entries.count).to eq(2)
      end

      it 'parses the id' do
        expect(first_entry.id).to eq('1')
      end

      it 'parses the title' do
        expect(first_entry.title).to eq('Awesome app')
      end

      it 'parses the review' do
        expect(first_entry.review).to eq(
          "Great app, add online ordering to the mix and I'll give it 5 stars"
        )
      end

      it 'parses the rating' do
        expect(first_entry.rating).to eq('4')
      end

      it 'parses the version' do
        expect(first_entry.version).to eq('1.02')
      end

      context 'author parsing' do
        it 'parses the name' do
          expect(first_entry.author.name).to eq('Test')
        end
        it 'parses the uri' do
          expect(first_entry.author.uri).to eq('https://itunes.apple.com/us/reviews/id12345')
        end
      end

      context 'invalid entry content' do
        let(:parser) do
          Criticism::Ios::Feed::Parser::Page.new(
            './spec/fixtures/ios/invalid_feed_file.xml'
          )
        end

        context 'invalid title parsing' do
          it 'returns empty string' do
            expect(first_entry.title).to eq('')
          end
        end

        context 'invalid review parsing' do
          it 'returns empty string' do
            expect(first_entry.review).to eq('')
          end
        end

        context 'invalid rating parsing' do
          it 'returns empty string' do
            expect(first_entry.rating).to eq('')
          end
        end
      end
    end
  end
end
