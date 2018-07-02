config_file_path = File.join(Rails.root, 'config', 's3_credentials.yml')
config_file = YAML.safe_load(ERB.new(File.read(config_file_path)).result)

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     config_file['access_key_id'],
    aws_secret_access_key: config_file['secret_access_key'],
    region:                config_file['aws_region'],
    path_style:            true
  }
  config.fog_directory  = config_file['aws_bucket']
  config.fog_public     = false
end
