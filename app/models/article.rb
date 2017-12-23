class Article < ApplicationRecord
  validates :title, :body, presence: true

  belongs_to :user

  default_scope { order(created_at: :desc) }
end
