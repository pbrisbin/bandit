require 'bandit/config'
require 'bandit/scores'
require 'bandit/store'

module Bandit
  class Main
    def self.run(argv)
      player = Config.player
      album  = nil

      while !album || album == Store.last_album
        if Config.exploring?
          album = player.albums.sample
        else
          album = Scores.best || player.albums.sample
        end
      end

      if last_skip = Store.last_skip
        Scores.adjust(player.current, Time.now - last_skip)
      end

      player.load(album)

      Store.last_skip  = Time.now
      Store.last_album = album
    end
  end
end
