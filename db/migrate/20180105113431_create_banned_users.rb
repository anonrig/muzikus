class CreateBannedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :banned_users do |t|
      t.integer :user
      t.datetime :banned_until
      t.string :reason

      t.timestamps
    end
  end
end
