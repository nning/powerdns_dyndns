module PowerDNS
  module DynDNS
    class AppConfig < Hash
      include Singleton
      
      def initialize
        self.merge! \
          YAML.load_file \
            File.expand_path \
              File.join \
                File.dirname(__FILE__),
                '..',
                '..',
                'settings.yml'
      end

      private

      def paths
        [
          File.dirname(__FILE__) + '../../settings.yml',
          '~/.config/PowerDNS/dyndns.yml'
        ]
      end
    end
  end
end
