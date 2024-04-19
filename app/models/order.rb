class Order < ApplicationRecord
  enum pay_type: {
         "Check" => 1,
         "Credit card" => 2,
         "Purchase order" => 3
       }
end
