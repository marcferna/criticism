require 'spec_helper'

describe Criticism::Android do
  let(:credentials) do
    Criticism::Android::Credentials.new(
      service_account: 'email@google.com',
      private_key:     'my_private_key'
    )
  end

  let(:android) do
    Criticism::Android.new(
      project_id:  project_id,
      bucket_id:   bucket_id,
      credentials: credentials,
      bundle_id:   bundle_id,
      date:        date
    )
  end

  let(:project_id) { 'this-is-my-project-id' }
  let(:bucket_id) { 'this-is-my-bucket-id' }
  let(:bundle_id) { 'com.test.app' }
  let(:date) { Time.new(1987, 5, 26).getlocal.to_date }

  describe '#reviews' do
    it 'returns Criticism::Review elements' do
      expect(android.reviews.first).to be_kind_of(Criticism::Review)
    end

    it { expect(android.reviews.count).to be(8) }

    it 'returns only the reviews' do
      expect(android.reviews.map(&:text).compact.count).to be(8)
    end
  end

  describe '#next' do
    it 'moves the date back' do
      expect { android.next }.to change {
        android.send(:date)
      }.to(Time.new(1987, 4, 26).getlocal.to_date)
    end

    it 'sets the cloud month' do
      expect { android.next }.to change {
        android.send(:cloud).send(:month)
      }.to(4)
    end

    it 'sets the cloud year' do
      expect { android.next }.to_not change {
        android.send(:cloud).send(:year)
      }
    end

    context 'when date is a Time object' do
      let(:date) { Time.new(1987, 5, 26).getlocal }

      it 'moves the date back' do
        expect { android.next }.to change {
          android.send(:date)
        }.to(Time.new(1987, 4, 26).getlocal.to_date)
      end
    end

    context 'when January 1st' do
      let(:date) { Time.new(1987, 1, 1).getlocal.to_date }

      it 'moves the date back' do
        expect { android.next }.to change {
          android.send(:date)
        }.to(Time.new(1986, 12, 1).getlocal.to_date)
      end

      it 'sets the cloud month' do
        expect { android.next }.to change {
          android.send(:cloud).send(:month)
        }.to(12)
      end

      it 'sets the cloud year' do
        expect { android.next }.to change {
          android.send(:cloud).send(:year)
        }.to(1986)
      end
    end
  end

  describe '#previous' do
    it 'moves the date forward' do
      expect { android.previous }.to change {
        android.send(:date)
      }.to(Time.new(1987, 6, 26).getlocal.to_date)
    end

    it 'sets the cloud month' do
      expect { android.previous }.to change {
        android.send(:cloud).send(:month)
      }.to(6)
    end

    it 'sets the cloud year' do
      expect { android.previous }.to_not change {
        android.send(:cloud).send(:year)
      }
    end

    context 'when date is a Time object' do
      let(:date) { Time.new(1987, 5, 26).getlocal }

      it 'moves the date forward' do
        expect { android.previous }.to change {
          android.send(:date)
        }.to(Time.new(1987, 6, 26).getlocal.to_date)
      end
    end

    context 'when December 31st' do
      let(:date) { Time.new(1987, 12, 31).getlocal.to_date }

      it 'moves the date forward' do
        expect { android.previous }.to change {
          android.send(:date)
        }.to(Time.new(1988, 1, 31).getlocal.to_date)
      end

      it 'sets the cloud month' do
        expect { android.previous }.to change {
          android.send(:cloud).send(:month)
        }.to(1)
      end

      it 'sets the cloud year' do
        expect { android.previous }.to change {
          android.send(:cloud).send(:year)
        }.to(1988)
      end
    end
  end
end
