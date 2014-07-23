class AddColumnToBudget < ActiveRecord::Migration
  def change
    add_column :budgets, :type, :string
  end
end
