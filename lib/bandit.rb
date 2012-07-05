require 'bandit/config'
require 'bandit/scores'
require 'bandit/store'
require 'bandit/player'
require 'bandit/players/mpc'

module Bandit
  class Main
    def self.run(argv)
      # if we're explicitly exploring, or we don't have enough info to
      # determine a best, then choose an album at random.
      if Config.exploring? || (album = Scores.best).nil?
        album = Config.player.albums.sample
      end

      raise "unable to find any albums." unless album

      if album == (current = Config.player.current)
        # same as current, just try again
        return run(argv)
      end

      if current && (last_skip = Store.last_skip)
        Scores.adjust(current, Time.now - last_skip)
      end

      Config.player.load(album)
      Config.player.show_status ||
        puts(%{ => "#{album}" loaded. })

      Store.last_skip = Time.now

    rescue => ex
      $stderr.puts "error: #{ex}"
      $stderr.puts "#{ex.backtrace.join("\n")}"
      exit 1
    end
  end
end
