class SearchController < ApplicationController
  SEARCH_FILTERS = [:author, :committed_at, :commit_hash]
  
  def search
    @authors = Author.all
    commits = Commit.includes(:author).order(committed_at: :desc)
    SEARCH_FILTERS.each do |filter|
      commits = add_search_filter(commits, filter)
    end
    commits = [] if no_search_terms
    flash[:success] = "Found #{commits.count} results"
    @presenter = commits.map { |commit| CommitPresenter.new(commit) }
  end

  private

  def no_search_terms
    SEARCH_FILTERS.map { |filter| params[filter].blank? }.all? { |blank| blank == true }
  end

  def add_search_filter(relation, field)
    if params[field].present?
      relation.merge(Commit.send("search_by_#{field}",params[field]))
    else
      relation
    end
  end
end
