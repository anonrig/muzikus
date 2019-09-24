class AddDetailToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :detail, :string
  end
end
