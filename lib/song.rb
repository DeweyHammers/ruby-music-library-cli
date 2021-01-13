class Song
    attr_accessor :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.genre = genre if genre != nil
        self.artist = artist if artist != nil
        save()
    end

    def save
        @@all << self
    end

    def genre=(genre)
        if @genre != genre
            @genre = genre
            genre.songs << self
        end 
    end

    def artist=(artist)
        @artist = artist
        @artist.genres.include?(@genre) ? nil : @artist.genres << @genre
        artist.add_song(self)
    end

    def self.create(name) 
        name = Song.new(name)
        name
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
end


