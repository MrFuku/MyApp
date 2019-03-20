class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :micropost, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:micropost_id, :user_id], unique: true
  end
end
