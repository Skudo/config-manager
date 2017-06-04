require 'pathname'
require 'thor'

require 'config_manager/configuration'
require 'config_manager/file'
require 'config_manager/encrypted_file'
require 'config_manager/version'

require 'config_manager/cli'

module ConfigManager
  def self.configuration
    @configuration ||= Configuration.new
  end
end
