class CreateScouts < ActiveRecord::Migration
  def change
    create_table :scouts do |t|
      t.string :BirinciEns
      t.string :BirinciSev
      t.string :BirinciYil
      t.string :IkinciEns
      t.string :IkinciSev
      t.string :IkinciYil
      t.string :VokalYetenek
      t.string :SahneTecrubesi
      t.text :UyeGruplar
      t.text :SevdiginGruplar
      t.integer :user_id

      t.timestamps
    end
  end
end
