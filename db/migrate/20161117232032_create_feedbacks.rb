class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.references :answer, :order
      t.text :description

      t.timestamps
    end
    add_foreign_key :feedbacks, :answers
    add_foreign_key :feedbacks, :orders
  end
end
