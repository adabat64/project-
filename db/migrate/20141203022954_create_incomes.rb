class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :amount_in
      t.string :from
      t.string :received_on
      t.string :tagged_to
      t.string :grouped_with
    end
  end
end
