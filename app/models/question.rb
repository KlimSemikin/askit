# frozen_string_literal: true

class Question < ApplicationRecord
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, presence: true, length: { minimum: 2 }
end
