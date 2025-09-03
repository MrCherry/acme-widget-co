# frozen_string_literal: true

module AcmeWidgetCo
  module Offers
    # Green + Blue bundle: Buy green and blue widget together, get $5 off
    class GreenBlueBundle < BaseOffer
      GREEN_WIDGET_CODE = 'G01'
      BLUE_WIDGET_CODE = 'B01'
      BUNDLE_DISCOUNT = 500 # $5.00 in cents

      def calculate_discount(items, catalogue)
        return 0 unless applicable?(items, catalogue)

        green_quantity = find_item_quantity(items, GREEN_WIDGET_CODE)
        blue_quantity = find_item_quantity(items, BLUE_WIDGET_CODE)

        # Number of complete bundles (limited by the smaller quantity)
        bundle_count = [green_quantity, blue_quantity].min
        bundle_count * BUNDLE_DISCOUNT
      end

      def applicable?(items, _catalogue)
        has_green = find_item_quantity(items, GREEN_WIDGET_CODE).positive?
        has_blue = find_item_quantity(items, BLUE_WIDGET_CODE).positive?
        has_green && has_blue
      end

      private

      def find_item_quantity(items, product_code)
        item = items.find { |item| item.product_code == product_code }
        item ? item.quantity : 0
      end
    end
  end
end
