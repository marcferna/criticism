module Criticism
  class Android
    def initialize(project_id:, bucket_id:, credentials: nil, bundle_id:, date:)
      @cloud = Criticism::Android::Cloud.new(
        project_id: project_id,
        bucket_id:  bucket_id,
        credentials: credentials || Criticism::Android::Credentials.new
      )
      @bundle_id = bundle_id
      @date = date.to_date
      set_cloud_date
    end

    def reviews
      cloud.file(bundle_id: bundle_id).reviews
    end

    def next
      @date = date << 1
      set_cloud_date
      self
    end

    def previous
      @date = date >> 1
      set_cloud_date
      self
    end

    private

    attr_reader :cloud, :bundle_id, :date

    def set_cloud_date
      cloud.month = date.month
      cloud.year = date.year
    end
  end
end
