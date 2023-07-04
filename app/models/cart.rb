class Cart < ApplicationRecord
    validates :book_id, presence: true
    validates :user_id, presence: true

    belongs_to :user
    belongs_to :book
end
