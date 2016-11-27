class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.integer :subject_id
      t.integer :user_id
      t.text :body

      t.timestamps null: false
    end
  end
end
