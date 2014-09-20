class AddColumnToRoomschedule < ActiveRecord::Migration
  def change
    add_column :roomschedules, :day, :integer
  end
end
