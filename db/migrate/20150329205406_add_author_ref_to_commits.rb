class AddAuthorRefToCommits < ActiveRecord::Migration
  def change
    add_reference :commits, :author, index: true
    add_foreign_key :commits, :authors
  end
end
