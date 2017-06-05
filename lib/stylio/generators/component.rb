require 'colorize'
module Stylio
  module Generators
    class Component
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def generate
        puts "Generating component with name #{name}".yellow
        FileUtils::mkdir_p "components/#{name}"
        puts "Created folder components/#{name}".green
        File.open("components/#{name}/#{name}.yml", 'w') do |f|
          f.write('')
        end
        puts "Created file components/#{name}/#{name}.yml".green
        File.open("components/#{name}/#{name}.html.erb", 'w') do |f|
          f.write('')
        end
        puts "Created file components/#{name}/#{name}.html.erb".green
        puts "Generated component with name #{name}".green
      end
    end
  end
end
