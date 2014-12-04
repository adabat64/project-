class AddBudgetIdToExpenses < ActiveRecord::Migration
  def change
    change_table :expenses do |t|
      t.integer :budget_id
    end
  end
end
