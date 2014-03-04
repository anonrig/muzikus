class Rename < ActiveRecord::Migration
  def change
  	rename_column :budgets, :type, :budget_type
  end
end
