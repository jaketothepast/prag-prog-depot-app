class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  enum pay_type: {
         "Check" => 1,
         "Credit card" => 2,
         "Purchase order" => 3
       }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys
end
