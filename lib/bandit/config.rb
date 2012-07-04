require 'singleton'

module Bandit
  class Config
    include Singleton

    def self.method_missing(*args, &block)
      self.instance.send(*args, &block)
    end

    # Exploration will occur 30% of the time.
    def exploring?
      rand(100) <= 30
    end

    # If you skip within 2 minutes, the album's value will drop by 1. If
    # you skip between 2 and 10 minutes, the albums value will increase
    # by 1. If you skip between 10 and 60 minutes, by 3. Finally, if the
    # album plays for 60 minutes or more, its value will increase by 5.
    def thresholds
      @thresholds = [ [ 2  * 60, -1 ],
                      [ 10 * 60,  1 ],
                      [ 60 * 60,  3 ],
                      [ nil,      5 ] ]
    end

    # Default player uses the mpc binary.
    def player
      @player ||= Player::Mpc.new
    end

    # Storage is kept in a file in your XDG_CACHE director or a dotfile
    # in HOME, whichever is defined.
    def storage
      @storage ||= if xdg = ENV['XDG_CACHE_HOME']
                     File.join(xdg, 'bandit.pstore')
                   else
                     File.join(ENV['HOME'], '.bandit.pstore')
                   end
    end
  end
end
