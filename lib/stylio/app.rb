require 'sinatra'
require 'yaml'

module Stylio
  class App < Sinatra::Base
    enable :run
    register Sinatra::Assets
    Bundler.require :default

    set :root, File.realpath(File.dirname(__FILE__))
    set :app_path, ''
    set :views, [settings.app_path, File.join(settings.root, 'views')]
    set :assets, File.join(settings.app_path, 'assets')
    set :components, File.join(settings.app_path, 'components')
    set :layouts, File.join(settings.app_path, 'layouts')
    set :styles, File.join(settings.app_path, 'assets', 'stylesheets')

    get '/' do
      erb :elements, layout: :styleguide
    end

    get '/elements' do
      erb :elements, layout: :styleguide
    end

    get '/components' do
      components = File.join(settings.app_path, 'components')
      directories = Dir.entries(components).select {|f| !File.directory? f}
      erb :components,
        locals: {
          components: directories
        }, layout: :styleguide
    end

    get '/components/:id' do
      name = params[:id]
      path = File.join(settings.app_path, 'components', name)

      erb :component,
        locals: {
          name: name,
          path: path,
          fixtures: YAML.load_file(File.join(path, "#{ name }.yml"))
        }, layout: :styleguide
    end

    get '/layouts' do
      layouts = File.join(settings.app_path, 'layouts')
      directories = Dir.entries(layouts).select {|f| !File.directory? f}
      erb :layouts,
        locals: {
          layouts: directories
        }, layout: :styleguide
    end

    get '/layouts/:id' do

      name = params[:id]
      path = File.join(settings.app_path, 'layouts', name)

      erb :layout,
        locals: {
          name: name,
          path: path
        }, layout: :styleguide
    end

    helpers do
      def render_component(name, key)
        path = File.join(settings.app_path, 'components', name)
        yaml = YAML.load_file(File.join(path, "#{ name }.yml"))
        erb :"#{path}/_#{name}.html", locals: { params: yaml[key.to_s] }
      end
    end
  end
end
