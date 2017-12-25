class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :body, presence: true

  scope :persisted, -> { where.not(id: nil) }
end
