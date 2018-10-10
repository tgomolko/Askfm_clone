class AddAnswerToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :answer, :text
    add_column :questions, :answered, :boolean, default: false
  end
end
