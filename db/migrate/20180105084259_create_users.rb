class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :phone_num
      t.boolean :is_member
      t.boolean :is_yk
      t.boolean :is_myk
      t.boolean :is_workshop
      t.boolean :is_drum

      t.timestamps
    end
  end
end
