class JoinAnswersQuestions < ActiveRecord::Migration[5.0]
  def up
    create_table :answers_questions, :id => false do |t|
      t.references :answer, :question
    end
    add_foreign_key :answers_questions, :answers
    add_foreign_key :answers_questions, :questions
  end

  def down
    drop_table :answers_questions
  end
end
