module PowerDNS
  module DynDNS
    class AppConfig < Hash
      include Singleton

      def initialize
        reload!
      end

      def reload!
        clear

        paths.each do |path|
          begin
            self.merge!(YAML.load_file(File.expand_path(path)))
          rescue Errno::ENOENT
          end
        end
      end

      private

      def paths
        a = []

        if ENV['RACK_ENV'] == 'test'
          a << File.dirname(__FILE__) + '/settings.yml'
        end

        a << '~/.config/PowerDNS/dyndns.yml'
      end
    end
  end
end
