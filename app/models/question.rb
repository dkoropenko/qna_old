class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :answers
  validates :title, :body, :user_id, presence: true
  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 10 }

  def belongs?(user)
    self.user == user
  end
end
