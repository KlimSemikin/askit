class Question < ApplicationRecord
  validates :title, :body, presence: true, length: {minimum: 2}
end
