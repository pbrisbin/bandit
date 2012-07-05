module Bandit
  # The Player class serves as a blueprint for concrete subclasses which
  # provide the actual shell commands for doing what's needed.
  class Player
    # Replace the current playlist with the passed album's tracks and
    # leave the player playing. In most players this will be a stop,
    # clear, load, play series of operations.
    def load(album)
      unimplemented
    end

    # Return the currently loaded/playing track's album. If this can't
    # be determined, return nil.
    def current
      unimplemented
    end

    # Return a list of all albums in your collection. The items in this
    # list will be passed to the #load method when that albums is to be
    # loaded.
    def albums
      unimplemented
    end

    # Print status information to stdout. This is called after a change
    # to the playlist has been made. Return nil if your player doesn't
    # support it and Bandit will just output the album it has selected.
    def show_status
      nil
    end

    protected

    # runs a command, hides output, but raises an error if the command
    # returns non-zero.
    def run_system(cmd)
      unless system("#{cmd} &>/dev/null")
        raise "Command #{cmd.inspect} returned non-zero: #{$?}"
      end
    end

    private

    def unimplemented
      raise "#{self.class} does not implement the required methods."
    end
  end
end
