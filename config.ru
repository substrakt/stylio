require 'rubygems'
require 'bundler'
Bundler.setup

require 'sprockets'
map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path File.join("assets", "javascripts")
  run environment
end

require 'stylio'
run Stylio::App
