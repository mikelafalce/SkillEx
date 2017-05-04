unless Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCESS_KEY'],                        # required
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],                        # required
      region:                'us-east-2',                  # optional, defaults to 'us-east-1'
      host:                  's3-us-east-2.amazonaws.com',             # optional, defaults to nil
      endpoint:              'http://s3-us-east-2.amazonaws.com/skill-ex' # optional, defaults to nil
    }
    config.fog_directory  = 'skill-ex'                          # required
    config.fog_public     = false                                        # optional, defaults to true
    config.fog_attributes = { cache_control: "public, max-age=#{365.day.to_i}" } # optional, defaults to {}
    config.storage = :fog
  end
end