# frozen_string_literal: true

module AcmeWidgetCo
  module Offers
    # Base template for offers using Strategy pattern
    class BaseOffer
      def calculate_discount(items, catalogue)
        raise NotImplementedError, 'Subclasses must implement this method'
      end

      def applicable?(items, catalogue)
        raise NotImplementedError, 'Subclasses must implement this method'
      end
    end
  end
end
