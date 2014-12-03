class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :amount_exp
      t.string :from
      t.string :received_on
      t.string :tagged_to
      t.string :grouped_with
    end
  end
end
