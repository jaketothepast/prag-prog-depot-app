class Product < ApplicationRecord
  # EZ Validator, used to ensure nothing is empty
  validates :title, :description, :image_url, presence: true
  validates :title, length: { minimum: 10 }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true

  validates :image_url, allow_blank: true, format: {
              with: %r{\.(gif|jpg|png)\z}i,
              message: "URL must be gif, jpg, or png"
            }
end
