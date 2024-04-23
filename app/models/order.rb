require 'pago' # Requires our lib/pago.rb module that we have created
#
class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  enum pay_type: {
         "Check" => 1,
         "Credit card" => 2,
         "Purchase order" => 3
       }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item # This is the array concat operator in Ruby.
    end
  end

  def charge!(pay_type_params)
    payment_details = {}
    payment_method = nil

    # Map the parameters to what Pago is expecting.
    case pay_type
    when "Check"
      payment_method = :check
      payment_details = { routing: pay_type_params[:routing_number], account: pay_type_params[:account_number] }
    when "Credit card"
      payment_method = :credit_card
      month,year = pay_type_params[:expiration_date].split(//)
      payment_details = {
        cc_num: pay_type_params[:credit_card_number],
        month: month,
        year: year
      }
    when "Purchase order"
      payment_method = :po
      payment_details = { po_num: pay_type_params[:po_number] }
    end

    # Make our actual payment. id is an attr on the model.
    payment_result = Pago.make_payment(
      order_id: id,
      payment_method: payment_method,
      payment_details: payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise payment_result.error
    end
  end
end
