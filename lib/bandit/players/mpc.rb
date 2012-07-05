module Bandit
  module Players
    class Mpc < Player
      def load(album)
        # sometimes mpc can be flaky, so we'll run separate system
        # commands so that a failure is caught where it happens.
        run_system('mpc stop')
        run_system('mpc clear')
        run_system("mpc findadd album '#{album}'")
        run_system('mpc play')
      end

      def current
        `mpc current --format '%album%'`.strip.tap do |str|
          return nil if str == ""
        end
      end

      def albums
        `mpc list album`.split("\n")
      end

      def show_status
        system('mpc')
      end
    end
  end
end
