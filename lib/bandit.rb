require 'bandit/config'

module Bandit
  class Main
    def self.run(argv)
      player = Config.player

      if album = player.albums.sample
        player.load(album)
      end
    end
  end
end
