class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.integer :parent_question_id
      t.integer :child_question_id
      t.text :text

      t.timestamps
    end
    add_foreign_key :answers, :questions, column: :parent_question_id
    add_foreign_key :answers, :questions, column: :child_question_id
  end
end
