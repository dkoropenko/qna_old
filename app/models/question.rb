class Question < ApplicationRecord
  has_many :answers, -> { order 'is_best desc' }, dependent: :destroy  
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :title, :body, :user_id, presence: true
  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 10 }

  accepts_nested_attributes_for :attachments

  def belongs?(user)
    self.user.id == user.id if self.user.present? && user.present?
  end
end
