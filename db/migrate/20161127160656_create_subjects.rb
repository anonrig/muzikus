class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.text :title

      t.timestamps null: false
    end
  end
end
