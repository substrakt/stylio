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
    set :bind, '0.0.0.0'
    settings.javascripts.append_path 'assets/javascripts'
    settings.javascripts.js_compressor  = :uglify

    get '/' do
      redirect to('/elements')
    end

    get "/assets/application.js" do
      content_type "application/javascript"
      settings.javascripts["application.js"]
    end

    get '/fonts/:file' do
      File.read(File.join(settings.app_path, 'assets', 'fonts', params[:file]))
    end

    get '/elements' do
      render_application_partial(:elements, layout: :styleguide)
    end

    get '/components' do
      erb :components,
        locals: {
          components: find_files('components')
        }, layout: :styleguide
    end

    get '/components/:id' do
      name = params[:id]
      path = File.join(settings.app_path, 'components', name)

      erb :component,
        locals: {
          name: name,
          path: path,
          fixtures: choose_fixture(path, name)
        }, layout: :styleguide
    end

    get '/layouts' do
      erb :layouts,
        locals: {
          layouts: find_files('layouts')
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
      erb :examples,
        locals: {
          examples: find_files('examples')
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

    def find_files(type)
      root_folder = File.join(settings.app_path, type)
      directories = Dir.entries(root_folder).select {|f| !File.directory? f}
      directories.sort
    end

    def choose_fixture(path, name)
      if File.exists?(File.join("#{path}/#{ name }.yml.erb"))
        YAML.load(erb(:"#{path}/#{ name }.yml"))
      else
        YAML.load_file(File.join(path, "#{name}.yml"))
      end
    end

    helpers do
      def render_component(name, key)
        path = File.join(settings.app_path, 'components', name)
        yaml = YAML.load_file(File.join(path, "#{ name }.yml"))
        erb(:"#{path}/_#{name}.html", locals: { params: yaml[key.to_s] })
      end
      
      def sub_component(name, key)
        path = File.join(settings.app_path, 'components', name)
        yaml = YAML.load_file(File.join(path, "#{ name }.yml"))
        erb(:"#{path}/_#{name}.html", locals: { params: yaml[key.to_s] }).dump[1...-1].gsub('\n', '')
      end

      def render_yield(key)
        path = File.join(settings.app_path, request.path_info)
        erb :"#{path}/_#{key}.html"
      end

      def render_application_partial(key, opts = {})
        file = File.join(settings.app_path, 'stylio', key.to_s)
        if File.exist?("#{file}.erb")
          erb :"#{file}", opts
        else
          erb key, opts
        end
      end
    end
  end
end
