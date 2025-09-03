# frozen_string_literal: true

module AcmeWidgetCo
  module Offers
    # Bulk discount: 10% off when buying 5 or more items total
    class BulkDiscount < BaseOffer
      MINIMUM_QUANTITY = 5
      DISCOUNT_PERCENTAGE = 0.10

      def calculate_discount(items, catalogue)
        return 0 unless applicable?(items, catalogue)

        subtotal = calculate_subtotal(items, catalogue)
        (subtotal * DISCOUNT_PERCENTAGE).round(2)
      end

      def applicable?(items, _catalogue)
        total_quantity = items.sum(&:quantity)
        total_quantity >= MINIMUM_QUANTITY
      end

      private

      def calculate_subtotal(items, catalogue)
        items.sum do |item|
          product_price = catalogue.find!(item.product_code).price_cents
          product_price * item.quantity
        end
      end
    end
  end
end
