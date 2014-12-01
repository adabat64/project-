class CreateIncome < ActiveRecord::Migration
  def change
    create_table :income do |t|
      t.string :amounti
      t.string :descriptioni
      t.string :datei
      t.string :tagi
      t.string :groupi
  end
end
end
