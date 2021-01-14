class Song
    extend Concerns::Findable

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
        artist.add_song(self)
    end

    def self.new_from_filename(file)
        file = file.split /\s-\s|.mp3/  
        song = file[1]
        artist = Artist.find_or_create_by_name(file[0])
        genre = Genre.find_or_create_by_name(file[2])
        song = Song.new(song, artist, genre)
    end

    def self.create_from_filename(name)
        new_from_filename(name)
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