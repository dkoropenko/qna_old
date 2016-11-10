class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :delete_all

  validates :title, :body, :user_id, presence: true

  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 10 }
end
