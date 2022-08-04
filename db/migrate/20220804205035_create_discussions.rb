class CreateDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :discussions do |t|
      t.string :title, null: false
      t.integer :creator_id, null: false
      t.integer :project_id, null: false
      t.timestamps
    end

    add_index :discussions, :creator_id
    add_index :discussions, :project_id
  end
end
