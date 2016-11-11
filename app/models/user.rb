class User < ApplicationRecord
  has_many :answers
  has_many :questions

  validates :firstname, :lastname, presence: true
  validates :firstname, length: { minimum: 3 }
  validates :lastname, length: { minimum: 5 }
end
