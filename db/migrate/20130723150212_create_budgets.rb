class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :amount
      t.string :reason
      t.string :user_id

      t.timestamps
    end
  end
end
