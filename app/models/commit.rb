class Commit < ActiveRecord::Base
  belongs_to :bug
  belongs_to :author
  BUG_REGEX = /cr\s(?:#|number\s)?(\d+)/i
  scope :search_by_author, lambda { |author| where("authors.name LIKE '%#{author}%'").references(:authors) }
  scope :search_by_committed_at, lambda { |date| where("commits.committed_at LIKE '#{date}%'") }
  scope :search_by_commit_hash, lambda { |hash| where("commits.commit_hash LIKE '#{hash}%'") }
end
