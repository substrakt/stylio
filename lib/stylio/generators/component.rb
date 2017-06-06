require 'colorize'
module Stylio
  module Generators
    class Component
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

      def generate
        puts "Generating component with name #{name}".yellow
        FileUtils::mkdir_p "components/#{name}"
        puts "Created folder components/#{name}".green

        File.open(fullpath('yml'), 'w') do |f|
          f.write('')
        end
        puts "Created file #{fullpath('yml')}".green

        File.open(fullpath('html.erb'), 'w') do |f|
          f.write('')
        end
        puts "Created file #{fullpath('html.erb')}".green

        puts "Generated component with name #{name}".green
      end
    end
  end
end
