# frozen_string_literal: true

module AcmeWidgetCo
  # Offer engine for the ACME Widget Co
  # Calculates total discount from all applicable offers
  class OfferEngine
    attr_reader :offers

    def initialize(offers:, catalogue:)
      @offers = offers
      @catalogue = catalogue
    end

    def calculate_total_discount(items)
      applicable_offers = find_applicable_offers(items)

      # For now, we take the best single offer (not cumulative)
      # This prevents stacking offers which could lead to negative prices
      applicable_offers.map { |offer| offer.calculate_discount(items, @catalogue) }.max || 0
    end

    def find_applicable_offers(items)
      @offers.select { |offer| offer.applicable?(items, @catalogue) }
    end
  end
end
