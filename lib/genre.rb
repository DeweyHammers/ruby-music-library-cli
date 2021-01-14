class Genre
    extend Concerns::Findable
    attr_accessor :name, :songs

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        save()
    end

    def save
        @@all << self
    end

    def artists
        Song.all.collect {|song| song.genre == self ? song.artist : nil}.uniq
    end

    def self.create(name) 
        name = Genre.new(name)
        name
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end
end