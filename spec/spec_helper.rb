require 'bandit'
require 'timecop'

module Bandit
  class MockPlayer
    attr_reader :current, :albums

    def initialize
      @current = nil
      @playing = false
      @albums  = [ 'foo', 'bar',
                   'baz', 'bat' ]
    end

    def load(album)
      @current = album
      @playing = true
    end

    def playing?
      @playing
    end
  end

  shared_context 'mock-player' do
    let(:player) { MockPlayer.new }

    before do
      Config.stub(:player).and_return(player)
    end
  end

  shared_context 'tmp-storage' do
    let(:tmp_file) { '/tmp/bandit_testing.pstore' }

    before do
      Config.stub(:storage).and_return(tmp_file)
    end

    after do
      File.unlink(tmp_file) if File.exists?(tmp_file)
    end
  end
end
