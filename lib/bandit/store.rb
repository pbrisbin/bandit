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

    # Access the hash of album-values. If block is given, yield this
    # value (allowing updates) and return the block return value;
    # otherwise, just return the hash of album-values.
    def self.albums
      pstore.transaction do |store|
        store[ALBUMS_KEY] ||= {}

        block_given? ? yield(store[ALBUMS_KEY])
                     : store[ALBUMS_KEY]
      end
    end

    # Get the value for the passed album
    def self.[](album)
      albums { |a| a[album] }
    end

    # Set the value for the passed album.
    def self.[]=(album, val)
      albums { |a| a[album] = val }
    end

    def self.pstore
      @pstore ||= PStore.new(Config.storage)
    end

    private_class_method :pstore

  end
end
