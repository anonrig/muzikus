class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to	:user, index: true
      t.belongs_to	:room, index: true
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :is_canceled

      t.timestamps
    end
  end
end
