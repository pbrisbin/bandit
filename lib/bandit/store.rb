require 'pstore'

module Bandit
  class Store
    LAST_SKIP_KEY = :last_skip
    ALBUMS_KEY    = :albums

    def self.last_skip
      pstore.transaction do |store|
        store[LAST_SKIP_KEY]
      end
    end

    def self.last_skip=(value)
      pstore.transaction do |store|
        store[LAST_SKIP_KEY] = value
      end
    end

    def self.albums
      pstore.transaction do |store|
        store[ALBUMS_KEY]
      end
    end

    def self.[](key)
      pstore.transaction do |store|
        store[ALBUMS_KEY] ||= {}
        store[ALBUMS_KEY][key]
      end
    end

    def self.[]=(key, val)
      pstore.transaction do |store|
        store[ALBUMS_KEY] ||= {}
        store[ALBUMS_KEY][key] = val
      end
    end

    def self.pstore
      @pstore ||= PStore.new(Config.storage)
    end

    private_class_method :pstore

  end
end
