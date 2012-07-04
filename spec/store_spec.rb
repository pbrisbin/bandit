require 'spec_helper'

module Bandit
  describe Store do
    include_context 'tmp-storage'

    it "has accessors" do
      Store.last_skip = t = Time.now
      Store.last_skip.should == t
    end

    it "can be persisted" do
      Store.last_skip = t = Time.now

      # TODO: simulate a stop/restart

      Store.last_skip.should == t
    end
  end
end
