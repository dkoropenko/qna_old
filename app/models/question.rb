class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, :user_id, presence: true
  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 10 }

  def belongs?(user)
    self.user.id == user.id if self.user.present? && user.present?
  end

  def clear_best_answers
    self.answers.each do |answer|
      answer.is_best = false
      answer.save
    end
  end

  def sort_by_best_answer
    answers = []
    answers << self.answers.map {|answer| answer if answer.is_best}
    answers << self.answers.map {|answer| answer unless answer.is_best}
    answers.flatten.compact
  end
end
