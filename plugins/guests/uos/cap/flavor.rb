module VagrantPlugins
  module GuestUos
    module Cap
      class Flavor
        def self.flavor(machine)
          # Read the version file
          version = ""
          machine.communicate.sudo("source /etc/os-release && printf $VERSION_ID") do |type, data|
            if type == :stdout
              version = data.split(".").first.to_i
            end
          end

          if version.nil? || version < 1
            :uos
          else
            "uos_#{version}".to_sym
          end
        end
      end
    end
  end
end
