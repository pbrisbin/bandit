require 'spec_helper'

module Bandit
  describe Scores, 'adjust' do
    let(:albums) { Hash.new }

    before do
      Store.stub(:albums).and_return(albums)
    end

    it "should adjust based on thresholds" do
      Scores.adjust('foo', 30)
      albums['foo'].should == -1

      Scores.adjust('bar', 2 * 60 + 1)
      albums['bar'].should == 1

      Scores.adjust('baz', 10 * 60 + 1)
      albums['baz'].should == 3

      Scores.adjust('bat', 60 * 60 + 1)
      albums['bat'].should == 5
    end
  end

  describe Scores, 'best' do
    it "should choose best" do
      Store.stub(:albums).and_return({'foo' => 2,
                                      'bar' => 6,
                                      'baz' => 3,
                                      'bat' => 2})

      Scores.best.should == 'bar'
    end

    it "should choose a random best" do
      Store.stub(:albums).and_return({'foo' => 2,
                                      'bar' => 3,
                                      'baz' => 3,
                                      'bat' => 2})

      ['bar', 'baz'].should include(Scores.best)

    end
  end
end
