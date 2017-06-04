module ConfigManager
  class CLI < ::Thor
    option :encrypted, type: :boolean, default: false
    desc 'create PATH', 'Create a config file at PATH'
    def create(*paths)
      paths.each do |path|
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
    end

    option :encrypted, type: :boolean, default: false
    desc 'import PATH', 'Import a config file at PATH'
    def import(*paths)
      paths.each do |path|
        begin
          source_path = ::File.expand_path(::File.join(current_directory, path))
          target_pathname = ::Pathname.new(source_path)

          home_path = ::Pathname.new(ENV['HOME'])
          relative_path = target_pathname.relative_path_from(home_path).to_s

          file = options[:encrypted] ? EncryptedFile.new(relative_path) : File.new(relative_path)
          raise ::Errno::EEXIST if file.exist?

          ::FileUtils.mkdir_p(file.directory) unless ::File.directory?(file.directory)
          ::FileUtils.mv(source_path, file.path)
          file.link_to(source_path)
        rescue ::Errno::EEXIST
          STDERR.puts "[ERR] #{source_path} could not be imported."
        end
      end
    end

    protected

    def current_directory
      Dir.pwd
    end
  end
end
