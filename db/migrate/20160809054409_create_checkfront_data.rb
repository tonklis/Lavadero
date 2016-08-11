class CreateCheckfrontData < ActiveRecord::Migration[5.0]
  def change
    create_table :checkfront_data do |t|
      t.text :bookings
      t.integer  :singleton_guard
      
      t.timestamps
    end
    add_index(:checkfront_data, :singleton_guard, :unique => true)    
  end
end
