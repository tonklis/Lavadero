class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :checkfront_id
      t.integer :client_id

      t.timestamps
    end
    add_foreign_key :orders, :clients
  end
end
