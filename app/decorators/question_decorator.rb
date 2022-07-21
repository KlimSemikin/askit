# frozen_string_literal: true

class QuestionDecorator < ApplicationDecorator
  delegate_all

  def formatted_created_at
    localize created_at, format: :long
  end
end
