module ConfigManager
  class EncryptedFile < File
    def path
      "#{super}.encrypted"
    end
  end
end
