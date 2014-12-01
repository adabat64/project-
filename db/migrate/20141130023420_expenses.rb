class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :amountx
      t.string :descriptionx
      t.string :datex
      t.string :tagx
      t.string :groupx
  end
end
end
