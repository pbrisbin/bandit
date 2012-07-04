require 'bandit/config'
require 'bandit/scores'
require 'bandit/store'
require 'bandit/player'
require 'bandit/player/mpc'

module Bandit
  class Main
    def self.run(argv)
      # if we're not exploring, we'll try and choose a best album
      album = Scores.best unless Config.exploring?

      # if we're exploring, we don't have a best album, or we happen to
      # choose the same album as last time, we'll choose one at random.
      # TODO: if your player can't give us a list of albums this goes
      # into an infinite loop...
      while album.nil? || album == Store.last_album
        album = Config.player.albums.sample
      end

      # adjust the score for the current song
      if (last_skip = Store.last_skip) && (current = Config.player.current)
        Scores.adjust(current, Time.now - last_skip)
      end

      # load the chosen album
      Config.player.load(album)

      # store some info for next time
      Store.last_skip  = Time.now
      Store.last_album = album
      Store.save

      puts %{ => "#{album}" loaded. }

    rescue => ex
      $stderr.puts "error: #{ex}"
      $stderr.puts "#{ex.backtrace.join("\n")}"
      exit 1
    end
  end
end
