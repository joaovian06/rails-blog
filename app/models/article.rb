class Article < ApplicationRecord
  enum category: [:scientific, :entertainment, :news]
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
  validates :category, presence: true
end
