class Artist
    attr_accessor :name, :songs, :genres

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @genres = []
        save()
    end

    def save
        @@all << self
    end

    def add_song(song)
        self.songs.include?(song) ? nil : self.songs << song
        song.artist = self if song.artist == nil
    end

    def self.create(name) 
        name = Artist.new(name)
        name
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
end
