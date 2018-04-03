class CreateFacultyLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :faculty_lessons do |t|
      t.belongs_to	:teacher, index: true
      t.string :name

      t.timestamps
    end
  end
end
