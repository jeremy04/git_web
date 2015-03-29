class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :commit_hash
      t.text :message
      t.datetime :committed_at, null: false
      t.timestamps null: false
    end
  end
end
