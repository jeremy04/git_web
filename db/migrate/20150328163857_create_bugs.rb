class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :cr_number
      t.timestamps null: false
    end
  end
end
