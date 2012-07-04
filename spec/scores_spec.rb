require 'spec_helper'

module Bandit
  describe Scores do
    include_context 'tmp-storage'

    it "should adjust based on thresholds" do
      Scores.adjust('foo', 30)
      Store['foo'].should == -1

      Scores.adjust('bar', 2 * 60 + 1)
      Store['bar'].should == 1

      Scores.adjust('baz', 10 * 60 + 1)
      Store['baz'].should == 3

      Scores.adjust('bat', 60 * 60 + 1)
      Store['bat'].should == 5
    end

    it "should choose best" do
      Store['foo'] = 2
      Store['bar'] = 6
      Store['baz'] = 3
      Store['bat'] = 2

      Scores.best.should == 'bar'
    end

    it "should choose a random best" do
      Store['foo'] = 2
      Store['bar'] = 3
      Store['baz'] = 3
      Store['bat'] = 2

      ['bar', 'baz'].should include(Scores.best)
    end
  end
end
