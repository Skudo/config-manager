module ConfigManager
  class Configuration
    def data_dir
      ::File.join(%W[#{ENV['HOME']} src config-files home])
    end
  end
end
