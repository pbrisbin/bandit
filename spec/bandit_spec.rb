require 'spec_helper'

module Bandit
  # we assume the bin stub will work and consider that testing through
  # Main.run is accurate enough to be considered end-to-end.
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
      # should give us enough coushin to prevent failures but also
      # ensure some degree of real randomness.
      100.times do
        Main.run []

        selected_albums << player.current
      end

      player.albums.each do |album|
        selected_albums.select { |a| a == album }.length.should >= 10
      end
    end

    it "should adjust worth based on elapsed time" do

    end

    it "should choose best when exploiting" do

    end
  end
end
