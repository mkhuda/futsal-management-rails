
CarrierWave.configure do |config|
  config.ftp_host = "45.32.252.124"
  config.ftp_port = 21
  config.ftp_user = "mkhuda"
  config.ftp_passwd = "muhammad"
  config.ftp_folder = "/var/www/html/sites/androgan/cdn/images"
  config.ftp_url = "http://androgan.com/cdn/images"
  config.ftp_passive = false # false by default

end