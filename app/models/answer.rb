class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true
  validates :body, length: { minimum: 10 }
  validates :is_best, inclusion: { in: [true, false] }

  def belongs?(user)
    self.user.id == user.id if self.user.present? && user.present?
  end

  def make_best!
    transaction do
      question.answers.update_all(is_best: false)
      update is_best: true
    end
  end
end
