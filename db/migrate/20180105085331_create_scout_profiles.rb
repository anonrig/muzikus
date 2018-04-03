class CreateScoutProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :scout_profiles do |t|
      t.belongs_to	:user, index: true
      t.datetime :birthday
      t.string :stage_exp
      t.string :vocal_exp
      t.text :bio
      t.boolean :is_hidden

      t.timestamps
    end
  end
end
