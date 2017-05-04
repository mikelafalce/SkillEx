CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines

  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJ56FN6GWFCNLHQQQ',                        # required
    :aws_secret_access_key  => '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',                     # required
    :region                 => 'us-east-2',                  # optional, defaults to 'us-east-1'
    :host                   => 's3.us-east-2.amazonaws.com',             # optional, defaults to nil
     # optional, defaults to nil
  }
  config.fog_directory  = 'directory'                             # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end