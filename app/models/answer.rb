class Answer < ApplicationRecord
  belongs_to :question

  validates :body, :question_id, presence: true
  validates :body, length: { minimum: 10 }
end
