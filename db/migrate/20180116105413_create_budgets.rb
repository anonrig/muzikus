class CreateBudgets < ActiveRecord::Migration[5.1]
  def change
    create_table :budgets do |t|
      t.integer :amount
      t.string :reason
      t.string :budget_type
      t.belongs_to	:user, index: true

      t.timestamps
    end
  end
end
