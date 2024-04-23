class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, pay_type_params)
    # Pull in the order object, and call charge with the paytype params from the controller
    order.charge!(pay_type_params)
  end
end
