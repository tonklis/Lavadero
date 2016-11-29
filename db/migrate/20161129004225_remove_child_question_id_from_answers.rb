class RemoveChildQuestionIdFromAnswers < ActiveRecord::Migration[5.0]
  def change
    remove_column :answers, :child_question_id
  end
end
