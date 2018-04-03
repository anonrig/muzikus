class CreateFacultyStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :faculty_students do |t|
      t.belongs_to	:user, index: true
      t.belongs_to	:faculty_lesson, index: true

      t.timestamps
    end
  end
end
