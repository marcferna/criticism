require 'spec_helper'

describe Criticism::Ios do
  let(:app_id) { 1_234_567 }
  let(:country) { 'es' }
  let(:language) { 'it' }

  let(:ios) do
    Criticism::Ios.new(
      app_id:   app_id,
      country:  country,
      language: language
    )
  end

  describe '#reviews' do
    it 'returns Criticism::Review elements' do
      expect(ios.reviews.first).to be_kind_of(Criticism::Review)
    end
  end

  describe '#next' do
    it 'gets the next page' do
      expect { ios.next }.to change {
        ios.instance_variable_get('@page')
      }
    end
  end

  describe '#previous' do
    it 'gets the previous page' do
      expect { ios.previous }.to change {
        ios.instance_variable_get('@page')
      }
    end
  end
end
