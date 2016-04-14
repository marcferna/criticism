require 'spec_helper'

describe Criticism::Feed::Page do

  describe '#new' do
    let(:feed) { Criticism::Feed.new(app_id: 528044963) }

    context 'test' do
      it 'test' do
        p feed.page.entries.first
      end
    end

  end
end
