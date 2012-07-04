module Bandit
  class Player::Mpc < Player
    def load(album)
      `mpc stop; mpc clear; mpc findadd album '#{album}'; mpc play`
    end

    def current
      `mpc current --format '%album%'`.strip.tap do |str|
        return nil if str == ""
      end
    end

    def albums
      `mpc list album`.split("\n")
    end
  end
end
