require 'coveralls'
Coveralls.wear!('rails')

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
  ]
)
SimpleCov.start 'rails'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'criticism'
require 'gcloud/storage/file'
require 'gcloud/storage/bucket'

RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(Criticism::Ios::Feed).to receive(:url) {
      './spec/fixtures/ios/feed_file.xml'
    }

    allow_any_instance_of(
      Gcloud
    ).to receive(:storage) {
      double(
        bucket: double(
          files: [Gcloud::Storage::File.new]
        )
      )
    }

    allow_any_instance_of(
      Gcloud::Storage::File
    ).to receive(:download) {
      open('./spec/fixtures/android/reviews_file.csv')
    }
  end
end
