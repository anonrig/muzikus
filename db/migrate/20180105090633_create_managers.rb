class CreateManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :managers do |t|
      t.belongs_to	:user, index: true
      t.belongs_to	:room, index: true
      t.string :manager_num

      t.timestamps
    end
  end
end
