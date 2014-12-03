class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.number :amount_in
      t.string :from
      t.number :received_on
      t.string :tagged_to
      t.string :grouped_with
    end
  end
end
