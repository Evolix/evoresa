env_file = File.expand_path('../../../config/environment', __FILE__)
require env_file

namespace :evoresa do
  desc "Show the current admin key"
  task :show_key do
    puts "Current key is: " + ADMIN_SECRET_KEY
    puts "Change with rake evoresa:set_key [KEY=<key>]"
  end

  desc "Set the current admin key"
  task :set_key do
    require 'digest/md5'

    file       = env_file + '.rb'
    config     = File.read(file)
    random_key = Digest::MD5.hexdigest(Array.new(32) { rand(128).chr }.join)
    new_key    = ENV['KEY'] || random_key

    config.sub!(/(ADMIN_SECRET_KEY) = '[^']+'/, '\1 = \'' + new_key + "'")
    File.open(file, 'w+') {|f| f.write(config) }

    puts "The new key is: " + new_key
  end
end
