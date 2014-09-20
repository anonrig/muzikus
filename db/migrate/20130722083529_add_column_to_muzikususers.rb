class AddColumnToMuzikususers < ActiveRecord::Migration
  def change
    add_column :muzikususers, :ismyk, :boolean
  end
end
