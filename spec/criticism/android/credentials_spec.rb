require 'spec_helper'

describe Criticism::Android::Credentials do
  let(:credentials) do
    Criticism::Android::Credentials.new(
      service_account: service_account,
      private_key:     private_key
    )
  end
  let(:service_account) { 'email@google.com' }
  let(:private_key) { 'my_private_key' }

  describe '#json_key' do
    it 'returns the right hash' do
      expect(credentials.json_key).to eq(
        private_key:  private_key,
        client_email: service_account
      )
    end
  end
end
