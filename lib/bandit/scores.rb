module Bandit
  class Scores
    def self.adjust(album, elapsed)
      Config.thresholds.each do |thr, adj|
        if !thr || elapsed < thr
          Store[album] ||= 0
          Store[album]  += adj
          return
        end
      end
    end

    def self.best
      best = Store.albums.values.max
      Store.albums.select { |_,v| v == best }.keys.sample
    end
  end
end
