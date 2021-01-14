class MusicImporter
    attr_reader :path

    def initialize(path)
        @path = path
    end

    def files
        filename = Dir.entries(path)
        mp3 = filename.select {|file| file.include?(".mp3")}
    end

    def import
        files.each {|file|Song.create_from_filename(file)}
    end
end