class Book < ApplicationRecord
  belongs_to :author
  validates :title, length: { minimum: 4, maximum: 30 }
  validates :description, length: { maximum: 500 }
end
