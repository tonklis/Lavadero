class AddRootToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :root, :boolean, default: false
  end
end
