require 'colorize'
require_relative 'generator'

module Stylio
  module Generators
    class Component < Generator
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def fullpath(extension)
        if extension == 'html.erb'
          "components/#{name}/_#{name}.#{extension}"
        else
          "components/#{name}/#{name}.#{extension}"
        end
      end

      def create_stylesheet
        create_directory('assets/stylesheets/2-components')
        create_file("assets/stylesheets/2-components/#{name}.scss")
        puts "! Don't forget to import your stylesheet.".red
      end

      def generate
        puts "Generating component with name '#{name}'".yellow
        create_directory "components/#{name}"
        create_file(fullpath('yml'))
        create_file(fullpath('html.erb'))
        create_stylesheet
        puts "Generated component with name #{name}".green
      end
    end
  end
end
