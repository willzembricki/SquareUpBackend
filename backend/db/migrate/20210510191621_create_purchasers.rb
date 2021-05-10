class CreatePurchasers < ActiveRecord::Migration[5.2]
  def change
    create_table :purchasers do |t|
      t.integer :round_id
      t.integer :person_id
      t.timestamp :time_of_purchase 
    end
  end
end
