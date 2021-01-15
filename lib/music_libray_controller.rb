class MusicLibraryController
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
        if input != "exit"
          get_input()  
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

    end
end