module Criticism
  class Android
    class Cloud
      require 'gcloud'
      require 'tempfile'

      attr_writer :month, :year

      def initialize(project_id:, bucket_id:, credentials:)
        @bucket = Gcloud.new(
          project_id, credentials.json_key
        ).storage.bucket(bucket_id)
      end

      def file(bundle_id:)
        @bundle_id = bundle_id
        @month = month
        @year = year
        Criticism::Android::Cloud::File.new(file: download_file)
      end

      private

      attr_reader :bucket, :bundle_id

      def download_file
        temp = Tempfile.new(['reviews', '.csv'])
        cloud_file.download(temp.path, verify: :none) unless cloud_file.nil?
      end

      def cloud_file
        bucket.files(prefix: file_path).first
      end

      def file_path
        format('reviews/reviews_%s_%04d%02d', bundle_id, year, month)
      end

      def month
        @month || Time.new.getlocal.month
      end

      def year
        @year || Time.new.getlocal.year
      end
    end
  end
end
