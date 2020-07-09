class Comment < ApplicationRecord
  belongs_to :article

  validates :article, presence: true

  validates :commenter, presence: true

  validates :body, presence: true
end
