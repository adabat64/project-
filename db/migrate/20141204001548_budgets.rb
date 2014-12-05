class Budgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :amount_bud
      t.string :from
      t.string :total_left
    end
  end
end
