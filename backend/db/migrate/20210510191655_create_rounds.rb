class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.float :price
      t.text :drinkers, array: true, default: []
    end

  end
end
