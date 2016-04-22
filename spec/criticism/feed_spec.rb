require 'spec_helper'

describe Criticism::Feed do
  describe '#new' do
    let(:app_id) { 1_234_567 }
    let(:country) { 'es' }
    let(:language) { 'it' }

    context 'arguments' do
      context 'all arguments present' do
        it 'sets app_id attribute' do
          expect(
            Criticism::Feed.new(
              app_id:   app_id,
              country:  country,
              language: language
            ).app_id
          ).to eq(
            app_id
          )
        end

        it 'sets country attribute' do
          expect(
            Criticism::Feed.new(
              app_id:   app_id,
              country:  country,
              language: language
            ).country
          ).to eq(
            country
          )
        end

        it 'sets language attribute' do
          expect(
            Criticism::Feed.new(
              app_id:   app_id,
              country:  country,
              language: language
            ).language
          ).to eq(
            language
          )
        end
      end

      context 'language argument missing' do
        it 'sets default language attribute' do
          expect(
            Criticism::Feed.new(app_id: app_id, country: country).language
          ).to eq(
            'en'
          )
        end
      end

      context 'country argument missing' do
        it 'sets default language attribute' do
          expect(
            Criticism::Feed.new(app_id: app_id, language: language).country
          ).to eq(
            'us'
          )
        end
      end
    end
  end
end
