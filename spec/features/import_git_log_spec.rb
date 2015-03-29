require "rails_helper"

describe "ImportGitLog" do
  describe "call" do
    it "creates authors,commits and bugs" do
      ImportGitLog.new.call("#{Rails.root}/db/data/git.log")
      Author.count.should == 3
      Commit.count.should == 11
      Bug.count.should == 3 
    end

    it "parses dates correctly" do
      ImportGitLog.new.call("#{Rails.root}/db/data/git.log")
      commit = Commit.where(commit_hash: "ae5a30e09082bd5b613c14235b0dd77109f21dcd").first
      commit.committed_at.should == Time.parse("2012-03-14 16:10:10")
    end
  end

end
