class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.float :price
      t.integer :person_id
     
    end

  end
end
