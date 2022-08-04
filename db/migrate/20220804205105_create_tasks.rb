class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :description, null: false
      t.integer :author_id, null: false
      t.integer :project_id, null: false
      t.timestamps
    end

    add_index :tasks, :author_id
    add_index :tasks, :project_id
  end
end
