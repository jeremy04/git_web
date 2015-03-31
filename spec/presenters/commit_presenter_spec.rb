require "rails_helper"

describe "CommitPresenter" do

  describe "author" do

    it "displays the name of the author" do
      author = double("author", name: "John Doe")
      commit = double("commit", author: author)
      presenter = CommitPresenter.new(commit)
      presenter.author.should == "John Doe"
    end

  end

  describe "message" do
    it "has a link to bugs" do
      bug = Bug.new(id: 1, cr_number: "38743")
      commit = Commit.new(bug: bug, message: "CR 38743. Fixing old")
      presenter = CommitPresenter.new(commit)
      presenter.message.should == "<a href=\"/bugs/1\">CR 38743</a>. Fixing old"
    end
  end

end