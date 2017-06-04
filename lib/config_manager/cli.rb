module ConfigManager
  class CLI < ::Thor
    option :encrypted, type: :boolean, default: false
    desc 'create PATH', 'Create a config file at PATH'
    def create(path)
      target_path = ::File.expand_path(::File.join(current_directory, path))
      target_pathname = ::Pathname.new(target_path)

      home_path = ::Pathname.new(ENV['HOME'])
      relative_path = target_pathname.relative_path_from(home_path).to_s

      file = options[:encrypted] ? EncryptedFile.new(relative_path) : File.new(relative_path)
      file.touch unless file.exist?

      target_directory = ::File.dirname(target_path)
      ::FileUtils.mkdir_p(target_directory) unless ::File.directory?(target_directory)
      file.link_to(target_path) unless ::File.exist?(target_path)
    end

    protected

    def current_directory
      Dir.pwd
    end
  end
end
