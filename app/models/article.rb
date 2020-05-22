class Article < ApplicationRecord
  has many :comments
  validates :title, presence: true,
                    length: { minimum: 5 }
end
