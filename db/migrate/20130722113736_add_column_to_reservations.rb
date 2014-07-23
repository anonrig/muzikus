class AddColumnToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :hour, :int
  end
end
