class AddUserIdToBudgets < ActiveRecord::Migration
  def change
    change_table :budgets do |t|
      t.integer :user_id
    end
  end
end
