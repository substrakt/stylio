require 'sinatra'
require 'yaml'
require 'sprockets'
require 'uglifier'

module Stylio
  class App < Sinatra::Base
    enable :run
    register Sinatra::Assets

    set :root, File.realpath(File.dirname(__FILE__))
    set :app_path, ''
    set :views, [settings.app_path, File.join(settings.root, 'views')]
    set :assets, File.join(settings.app_path, 'assets')
    set :components, File.join(settings.app_path, 'components')
    set :layouts, File.join(settings.app_path, 'layouts')
    set :styles, File.join(settings.app_path, 'assets', 'stylesheets')
    set :javascripts, Sprockets::Environment.new
    settings.javascripts.append_path 'assets/javascripts'
    settings.javascripts.js_compressor  = :uglify

    get '/' do
      erb :elements, layout: :styleguide
    end

    get "/assets/application.js" do
      content_type "application/javascript"
      settings.javascripts["application.js"]
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

      erb :styleguide, :layout => false do
        erb :"#{path}/#{name}.html" do
          "Yielded content"
        end
      end
    end

    get '/examples' do
      examples = File.join(settings.app_path, 'examples')
      directories = Dir.entries(examples).select {|f| !File.directory? f}
      erb :examples,
        locals: {
          examples: directories
        }, layout: :styleguide
    end

    get '/examples/:id' do

      name = params[:id]
      layouts = File.join(settings.app_path, 'layouts')
      path = File.join(settings.app_path, 'examples', name)
      yaml = YAML.load_file(File.join(path, "#{ name }.yml"))

      erb :styleguide, :layout => false do
        erb :"#{layouts}/#{yaml['layout']}/#{yaml['layout']}.html", :layout => false do
          erb :"#{path}/#{name}.html"
        end
      end
    end

    helpers do
      def render_component(name, key)
        path = File.join(settings.app_path, 'components', name)
        yaml = YAML.load_file(File.join(path, "#{ name }.yml"))
        erb :"#{path}/_#{name}.html", locals: { params: yaml[key.to_s] }
      end

      def render_yield(key)
        path = File.join(settings.app_path, request.path_info)
        erb :"#{path}/_#{key}.html"
      end
    end
  end
end
