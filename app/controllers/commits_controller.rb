class CommitsController < ApplicationController
  def index
    @authors = Author.all
    commits = Commit.includes(:author).order(committed_at: :desc)
    @presenter = commits.map { |commit| CommitPresenter.new(commit) }
  end
end
