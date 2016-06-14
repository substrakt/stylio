require 'sinatra'

module Sinatra
  module Assets
    module Helpers
      def css_link
        "<link href='/assets/application.css' rel='stylesheet' type='text/css' />"
      end

      def image_link(file)
        "/assets/images/#{ file }"
      end

      def find_template(views, name, engine, &block)
        Array(views).each do |v|
          super(v, name, engine, &block)
        end
      end
    end

    def self.registered(app)
      app.helpers Assets::Helpers

      app.get "/assets/application.css" do
        content_type("text/css")
        Sass::Engine.for_file(File.join(options.assets, "stylesheets", "application.scss"), {
          cache: false,
          syntax: :scss,
          style: :compressed
        }).render
      end

      app.get "/assets/application.js" do
        content_type("text/js")
        Sass::Engine.for_file(File.join(options.assets, "stylesheets", "application.scss"), {
          cache: false,
          syntax: :scss,
          style: :compressed
        }).render
      end

      %w{jpg png}.each do |format|
        app.get "/assets/images/:image.#{format}" do |image|
          content_type("image/#{format}")
          File.join(options.assets, "images", "#{image}.#{format}")
        end
      end
    end
  end

  register Assets
end
