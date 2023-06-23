class Book < ApplicationRecord
  belongs_to :author
  validates :title, length: { minimum: 4, maximum: 30 }
  validates :description, length: { maximum: 500 }
  validates :price, numericality: { greater_than: 0 }
  has_one_attached :cover
  
  validate :validate_cover_image_size

    def validate_cover_image_size
        return unless cover.attached?
    
        unless cover.blob.byte_size <= 4.megabyte
            raise ActiveStorage::IntegrityError, "Cover image should be less than 4MB"
        end
    end

end
