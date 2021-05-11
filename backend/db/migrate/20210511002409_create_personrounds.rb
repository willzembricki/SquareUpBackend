class CreatePersonrounds < ActiveRecord::Migration[5.2]
  def change
    create_table :person_rounds do |t|
      t.integer :person_id
      t.integer :round_id
    end
  end
end
