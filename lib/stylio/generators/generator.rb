require 'colorize'
module Stylio
  module Generators
    class Generator

      def initialize(*args)
        puts 'Do not call this class directly. Use one of the concrete subclasses.'.red
        return nil
      end

      def create_directory(path)
        FileUtils::mkdir_p path
      end

      def create_file(path)
        puts "Generating file: #{path}".yellow
        File.open(path, 'w') do |f|
          f.write('')
        end
        puts "✔ Created file: #{path}".green
      end
    end
  end
end
