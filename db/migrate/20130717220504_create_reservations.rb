class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :room_id
      t.timestamp :start_date
      t.timestamp :end_date
      t.boolean :isCanceled

      t.timestamps
    end
  end
end
