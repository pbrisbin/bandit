module Bandit
  class Scores
    # adjust the score the passed album based on the elapsed time and
    # configure threshold adjustments.
    def self.adjust(album, elapsed)
      Config.thresholds.each do |thr, adj|
        if !thr || elapsed < thr
          Store[album] ||= 0
          Store[album]  += adj
          return
        end
      end
    end

    # return the best album. if multiple albums have the highest score,
    # return a random one. if no albums exist with higher than 0 value
    # return false (triggering exploration).
    def self.best
      if (best = Store.albums.values.max) && best > 0
        Store.albums.select { |_,v| v == best }.keys.sample
      end
    end
  end
end
