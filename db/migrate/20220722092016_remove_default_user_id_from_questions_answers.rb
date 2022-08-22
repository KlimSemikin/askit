# frozen_string_literal: true

class RemoveDefaultUserIdFromQuestionsAnswers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :questions, :user_id, from: 1, to: nil
    change_column_default :answers, :user_id, from: 1, to: nil
  end
end
