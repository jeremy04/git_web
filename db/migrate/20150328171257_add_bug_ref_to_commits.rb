class AddBugRefToCommits < ActiveRecord::Migration
  def change
    add_reference :commits, :bug, index: true, column_options: {null: true}
    add_foreign_key :commits, :bugs
  end
end
