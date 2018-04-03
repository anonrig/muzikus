class CreateMusicianInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :musician_infos do |t|
      t.belongs_to	:scout_profile, index: true
      t.belongs_to	:instrument, index: true
      t.string :experience
      t.string :details

      t.timestamps
    end
  end
end
