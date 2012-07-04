require 'forwardable'
require 'pstore'
require 'singleton'

module Bandit
  class Store
    KEY = 'BanditStorage'
    ACCESSORS = [:last_skip, :last_album, :albums]

    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :load, :save, :data
    end

    ACCESSORS.each do |accessor|
      class_eval %{
        def self.#{accessor}
          data[#{accessor.inspect}]
        end

        def self.#{accessor}=(value)
          data[#{accessor.inspect}] = value
        end
      }
    end

    attr_reader :data

    def initialize
      @pstore = PStore.new(Config.storage)
      @pstore.transaction(true) do |store|
        @data = store[KEY] || {}
      end
    end

    def save
      @pstore.transaction do |store|
        store[KEY] = @data
      end
    end
  end
end
