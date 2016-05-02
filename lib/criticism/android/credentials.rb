module Criticism
  class Android
    class Credentials
      def initialize(service_account: nil, private_key: nil)
        @service_account = service_account
        @private_key = private_key
      end

      def json_key
        {
          private_key:  private_key,
          client_email: service_account
        }
      end

      private

      attr_reader :service_account, :private_key

      def service_account
        @service_account || ENV['ANDROID_SERVICE_ACCOUNT']
      end

      def private_key
        @private_key || ENV['ANDROID_PRIVATE_KEY']
      end
    end
  end
end
