class Question < ApplicationRecord
  belongs_to :user
  has_many :answers

  validates :title, :body, presence: true

  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 10 }
end
