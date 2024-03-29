CarrierWave.configure do |config|
  require 'carrierwave/storage/abstract'
  require 'carrierwave/storage/file'
  require 'carrierwave/storage/fog'

  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'],
    path_style: true
  }

  config.fog_public     = false
  config.fog_authenticated_url_expiration = 60
  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}

  case Rails.env
  when 'production'
    config.fog_directory = ENV['AWS_S3_BUCKET_PRODUCTION']
    config.asset_host = ENV['AWS_S3_URL_PRODUCTION']
  when 'development'
    config.fog_directory = ENV['AWS_S3_BUCKET_DEVELOPMENT']
    config.asset_host = ENV['AWS_S3_URL_DEVELOPMENT']
  when 'test'
    config.fog_directory = ENV['AWS_S3_BUCKET_TEST']
    config.asset_host = ENV['AWS_S3_URL_TEST']
  end

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
end