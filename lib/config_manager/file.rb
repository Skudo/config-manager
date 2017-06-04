module ConfigManager
  class File
    attr_reader :filename

    def initialize(path)
      @directory = ::File.dirname(path)
      @filename = ::File.basename(path)

      raise "Cannot create file in folder #{directory}" if ::File.exist?(@directory) && !::File.directory?(@directory)
    end

    def exist?
      ::File.exist?(path)
    end

    def directory
      ::File.join(::ConfigManager.configuration.data_dir, @directory)
    end

    def path
      ::File.join(directory, filename)
    end

    def touch
      if ::File.exist?(directory)
        raise "Cannot create folder #{path}." unless ::File.directory?(directory)
      else
        ::FileUtils.mkdir_p(directory)
      end

      ::FileUtils.touch(path)
      self
    end

    def link_to(target_path)
      ::FileUtils.ln_s(path, target_path)
      self
    end
  end
end
