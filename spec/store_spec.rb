require 'spec_helper'

module Bandit
  describe Store do
    include_context 'tmp-storage'

    it "can store last skip" do
      Store.last_skip = t = Time.now
      Store.last_skip.should == t
    end

    it "can adjust an album" do
      Store["Some Album"] ||= 0
      Store["Some Album"]  += 1
      Store["Some Album"].should == 1
    end

    it "can list all albums" do
      Store["An Album"]      = 1
      Store["Another Album"] = 2
      Store.albums.should == { "An Album"      => 1,
                               "Another Album" => 2 }
    end
  end
end
