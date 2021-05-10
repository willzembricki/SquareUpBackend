class CreatePersons < ActiveRecord::Migration[5.2]
  def change
    create_table :persons do |t|
      t.string :name
      t.float :balance
      t.float :total 
    end

  end
end
