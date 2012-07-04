module Bandit
  class Scores
    class << self
      def adjust(album, elapsed)
        Store.albums ||= {}

        Config.thresholds.each do |thr, adj|
          if !thr || elapsed < thr
            Store.albums[album] ||= 0
            Store.albums[album]  += adj
            return
          end
        end
      end

      def best
        max   = 0
        bests = []

        (Store.albums || []).each do |album, score|
          if score > max
            max   = score
            bests = [album]
          elsif score == max
            bests << album
          end
        end

        bests.sample
      end
    end
  end
end
