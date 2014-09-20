class CreateMuzikususers < ActiveRecord::Migration
  def change
    create_table :muzikususers do |t|
      t.string :email

      t.timestamps
    end
  end
end
