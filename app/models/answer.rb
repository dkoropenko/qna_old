class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 10 }

  def belongs?(user)
    self.user.id == user.id if self.user.present? && user.present?
  end
end
