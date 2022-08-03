class CreateProjectShares < ActiveRecord::Migration[7.0]
  def change
    create_table :project_shares do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :project_shares, %i[project_id user_id], unique: true
  end
end
