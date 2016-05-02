require 'spec_helper'

describe Criticism::Android::Cloud do
  let(:credentials) do
    Criticism::Android::Credentials.new(
      service_account: 'email@google.com',
      private_key:     'my_private_key'
    )
  end

  let(:cloud) do
    Criticism::Android::Cloud.new(
      project_id:  project_id,
      bucket_id:   bucket_id,
      credentials: credentials
    )
  end

  let(:project_id) { 'this-is-my-project-id' }
  let(:bucket_id) { 'this-is-my-bucket-id' }
  let(:bundle_id) { 'com.test.app' }

  describe '#file' do
    it 'returns a cloud file' do
      expect(cloud.file(bundle_id: bundle_id)).to be_kind_of(
        Criticism::Android::Cloud::File
      )
    end

    context '#dowload_file' do
      it { expect(cloud.send(:download_file)).to be_kind_of(File) }
    end

    context '#cloud_file' do
      it do
        expect(cloud.send(:cloud_file)).to be_kind_of(Gcloud::Storage::File)
      end
    end

    context '#file_path' do
      before do
        cloud.month = month
        cloud.year = year
      end
      let(:month) { 12 }
      let(:year) { 1934 }
      let!(:file) { cloud.file(bundle_id: bundle_id) }
      it 'constructs the right path' do
        expect(cloud.send(:file_path)).to eq(
          "reviews/reviews_#{bundle_id}_#{year}#{month}"
        )
      end
    end
  end
end
