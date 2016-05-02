require 'spec_helper'

describe Criticism::Android::Cloud::File do
  let(:headers) do
    [
      :package_name,
      :app_version_code,
      :app_version_name,
      :reviewer_language,
      :device,
      :review_submit_date_and_time,
      :review_submit_millis_since_epoch,
      :review_last_update_date_and_time,
      :review_last_update_millis_since_epoch,
      :star_rating,
      :review_title,
      :review_text,
      :developer_reply_date_and_time,
      :developer_reply_millis_since_epoch,
      :developer_reply_text,
      :review_link
    ]
  end

  let(:values) do
    [
      'com.test.app',
      nil,
      version,
      'en',
      'hammerhead',
      '2016-04-22T19:07:48Z',
      '1461352068527',
      '2016-04-22T19:07:48Z',
      '1461352068527',
      rating,
      title,
      text,
      nil,
      '2016-04-25T22:20:05Z',
      '1461622805923',
      review_link
    ]
  end
  let(:csv_row) { CSV::Row.new(headers, values, true) }

  let(:row) do
    Criticism::Android::Cloud::File::Row.new(
      row: csv_row
    )
  end

  let(:review) { row.review }

  let(:title) { 'Cool app!' }
  let(:text) { 'This app works very very well!' }
  let(:rating) { 4 }
  let(:version) { '2.34.5' }
  let(:id) { 'AOqpTRFIRJIEIDVRIHfrKDMCIVHRIHWOXWskcdihvridnk3944ru8s0-alkAuRk' }
  let(:review_link) do
    "https://play.google.com/apps/publish?account=1234567604960549604045#"\
        "ReviewDetailsPlace:p=com.test.app&reviewid=gp:#{id}"
  end

  describe '#review' do
    it 'sets the id' do
      expect(review.id).to eq(id)
    end

    it 'sets the title' do
      expect(review.title).to eq(title)
    end

    it 'sets the review' do
      expect(review.review).to eq(text)
    end

    it 'sets the rating' do
      expect(review.rating).to eq(rating)
    end

    it 'sets the version' do
      expect(review.version).to eq(version)
    end
  end

  describe '#review?' do
    context 'no review link' do
      let(:review_link) { nil }
      it { expect(row.review?).to be(false) }
    end

    context 'review link' do
      let(:review_link) { 'this-is-the-review-link' }
      it { expect(row.review?).to be(true) }
    end
  end
end
