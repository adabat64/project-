class Budgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :amount_bud
      t.string :from
    end
  end
end
