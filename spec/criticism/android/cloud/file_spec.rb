require 'spec_helper'

describe Criticism::Android::Cloud::File do
  let(:reviews_csv) { open('./spec/fixtures/android/reviews_file.csv') }

  let(:file) do
    Criticism::Android::Cloud::File.new(
      file: reviews_csv
    )
  end

  describe '#reviews' do
    it 'returns Criticism::Review elements' do
      expect(file.reviews.first).to be_kind_of(Criticism::Review)
    end

    it { expect(file.reviews.count).to be(8) }

    it 'returns only the reviews' do
      expect(file.reviews.map(&:review).count).to be(8)
    end
  end
end
