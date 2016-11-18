class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :text
      t.string :question_type
      t.boolean :required

      t.timestamps
    end
  end
end
