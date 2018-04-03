class CreateLessonSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :lesson_schedules do |t|
      t.belongs_to	:faculty_lesson, index: true
      t.belongs_to	:room, index: true
      t.string :weekday
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end
end
