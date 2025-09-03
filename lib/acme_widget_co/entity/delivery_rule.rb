# frozen_string_literal: true

module AcmeWidgetCo
  module Entity
    # Delivery rule for the delivery calculator
    # A rule is applicable if one of the following conditions is met:
    # - The total price is greater than or equal to the minimum total price (total_price >= min_total)
    # - The total quantity is greater than or equal to the minimum quantity (total_quantity >= min_quantity)
    # - The quantity of the product code is greater than or equal to the minimum quantity
    #   (product_code = basket_item.product_code && basket_item.quantity >= min_quantity)
    DeliveryRule = Struct.new(:min_total, :product_code, :min_quantity, :delivery_charge, keyword_init: true)
  end
end
