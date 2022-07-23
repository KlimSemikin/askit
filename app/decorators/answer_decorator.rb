# frozen_string_literal: true

class AnswerDecorator < ApplicationDecorator
  delegate_all
  decorates_association :user

  def formatted_created_at
    localize created_at, format: :short
  end
end
