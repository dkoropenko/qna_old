class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true

  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 10 }
end
