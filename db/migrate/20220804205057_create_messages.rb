class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.integer :author_id, null: false
      t.integer :discussion_id, null: false
      t.timestamps
    end

    add_index :messages, :author_id
    add_index :messages, :discussion_id
  end
end
