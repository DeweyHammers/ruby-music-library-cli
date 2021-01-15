class MusicLibraryController
    extend Concerns::Findable

    def initialize(path='./db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        get_input()
    end

    def get_input
        input = gets.chomp
        case input
        when "list songs"
            list_songs()
        when "list artists"
            list_artists()
        when "list genres"
            list_genres()
        when "list artist"
            list_songs_by_artist()
        when "list genre"
            list_songs_by_genre()
        when "play song"
            play_song()
        else
            if input != "exit"
                get_input()  
            end
        end
    end

    def list_songs
        num = 0
        songs = Song.all.sort_by {|song| song.name} 
        songs.map do |song|
            num += 1
            puts "#{num}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        num = 0
        artists = Artist.all.sort_by {|artist| artist.name}
        artists = artists.map {|artist|"#{artist.name}"}
        artists.uniq!
        artists.map do |artist|
           num += 1
           puts "#{num}. #{artist}"
        end
    end

    def list_genres
        num = 0
        genres = Song.all.sort_by {|song| song.genre.name}
        genres = genres.map {|song| song.genre.name}
        genres.uniq!
        genres.map do |genre|
            num += 1
            puts "#{num}. #{genre}"
         end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        match = []
        num = 0
        songs = Song.all.sort_by {|song| song.name} 
        songs.map {|song| match << song if song.artist.name == input}
        match.map do |song|
            num += 1 
            puts "#{num}. #{song.name} - #{song.genre.name}"
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        match = []
        num = 0
        songs = Song.all.sort_by {|song| song.name}
        songs.map {|song| match << song if song.genre.name == input}
        match.map do |song|
            num += 1 
            puts "#{num}. #{song.artist.name} - #{song.name}"
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp
        num = 0
        list = {}
        match = nil
        songs = Song.all.sort_by {|song| song.name}
        songs.map do |song|
            num += 1 
            list[num] = "Playing #{song.name} by #{song.artist.name}"
        end
        list.map  {|keys, values| keys == input.to_i ? match = values : false}
        puts match if match != nil
    end
end

