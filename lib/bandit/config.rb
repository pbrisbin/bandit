require 'singleton'

module Bandit
  class Config
    include Singleton

    def self.method_missing(*args, &block)
      self.instance.send(*args, &block)
    end

    def exploring?
      rand(100) >= 30
    end

    def thresholds
      [
        [ 2  * 60, -1 ],
        [ 10 * 60,  1 ],
        [ 60 * 60,  3 ],
        [ nil,      5 ]
      ]
    end
  end
end
