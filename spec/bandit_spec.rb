require 'spec_helper'

module Bandit
  # we assume the bin stub will work and consider that testing through
  # Main.run is accurate enough to be considered end-to-end. the only
  # thing we mock is the config, namely its player and wether or not
  # we're exploring.
  describe Main, 'run' do
    include_context 'mock-player'

    it "should load a new album" do
      previous = player.current

      Main.run []

      player.current.should_not == previous
      player.should be_playing
    end

    it "should randomly choose when exploring" do
      Config.stub(:exploring?).and_return(true)

      selected_albums = []

      # our mock player contains four albums. let's load a new album 100
      # times and assert that each album appears at least 15 times. this
      # should give us enough room to prevent flapping but also ensure
      # some degree of real distribution.
      100.times do
        Main.run []

        selected_albums << player.current
      end

      player.albums.each do |album|
        selected_albums.select { |a| a == album }.length.should >= 15
      end
    end

    it "should track and choose best when exploiting" do
      Config.stub(:exploring?).and_return(false)

      Main.run []

      first = player.current

      Timecop.travel(2 * 60 + 30) do # 2m30s later
        # this skip will add value to the first album and choose a
        # random second album.
        Main.run []
        (second = player.current).should_not == first

        Timecop.travel(10 * 60 + 30) do # 10m30s later
          # this skip will add more value to the second album than the
          # first and should choose the first (it's currently best).
          Main.run []
          player.current.should == first

          # at this point, both first and second have values (second
          # being higher) so we'll assert that's the one that's found.
          Main.run []
          player.current.should == second
        end
      end
    end
  end
end
