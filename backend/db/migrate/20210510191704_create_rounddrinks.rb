class CreateRounddrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :rounddrinks do |t|
      t.integer :round_id
      t.integer :drink_id
    end
    
  end
end
