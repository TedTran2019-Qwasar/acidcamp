class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.integer :creator_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.timestamps
    end
    add_index :projects, :creator_id
  end
end
