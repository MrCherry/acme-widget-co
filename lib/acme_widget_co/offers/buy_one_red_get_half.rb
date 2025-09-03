# frozen_string_literal: true

module AcmeWidgetCo
  module Offers
    # Buy one red widget, get the second half price
    class BuyOneRedGetHalf < BaseOffer
      RED_WIDGET_CODE = 'R01'

      def calculate_discount(items, catalogue)
        return 0 unless applicable?(items, catalogue)

        red_widget_item = find_red_widget_item(items)
        return 0 unless red_widget_item

        red_widget_price = catalogue.find!(RED_WIDGET_CODE).price_cents
        discounted_pairs = red_widget_item.quantity / 2

        # Each pair gets 50% off the second widget
        discounted_pairs * (red_widget_price / 2.0).round(2)
      end

      def applicable?(items, _catalogue)
        red_widget_item = find_red_widget_item(items)
        red_widget_item && red_widget_item.quantity >= 2
      end

      private

      def find_red_widget_item(items)
        items.find { |item| item.product_code == RED_WIDGET_CODE }
      end
    end
  end
end
