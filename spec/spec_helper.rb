require 'coveralls'
Coveralls.wear!('rails')

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'criticism'

RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(Criticism::Feed).to receive(:url) {
      './spec/fixtures/feed_file.xml'
    }
  end
end
