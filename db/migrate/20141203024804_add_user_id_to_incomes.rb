class AddUserIdToIncomes < ActiveRecord::Migration
  def change
    change_table :incomes do |t|
      t.integer :user_id
    end
  end
end
