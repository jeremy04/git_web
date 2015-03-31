class CommitPresenter
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def initialize(commit)
    @commit = commit
  end

  def commit_hash
    @commit.commit_hash
  end

  def message
    if @commit.message =~ Commit::BUG_REGEX
      @commit.message.gsub($&, link_to($&, bug_path(@commit.bug)))
    else
      @commit.message
    end
  end

  def committed_at
    @commit.committed_at
  end

  def author
    if @commit.author.present?
      @commit.author.name
    else
      "No Author"
    end
  end
end