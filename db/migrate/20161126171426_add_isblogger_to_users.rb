class AddIsbloggerToUsers < ActiveRecord::Migration
  def change
      add_column :muzikususers, :isblogger, :boolean
  end
end
