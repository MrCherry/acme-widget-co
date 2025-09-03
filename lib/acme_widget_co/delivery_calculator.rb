# frozen_string_literal: true

module AcmeWidgetCo
  # Delivery calculator for the ACME Widget Co
  # Calculates the delivery cost based on the rules and the items in the basket
  class DeliveryCalculator
    DEFAULT_DELIVERY_CHARGE = 495 # $4.95 in cents

    attr_reader :rules

    def initialize(catalogue:, rules: [])
      @rules = rules
      @catalogue = catalogue
    end

    def calculate(items)
      total_price = items.map { |item| get_product_price(item.product_code) * item.quantity }.sum
      calculate_for_total(items, total_price)
    end

    def calculate_for_total(items, total_price)
      total_items = items.map(&:quantity).sum

      rule = find_matched_rule(items, total_price, total_items)

      # No rule matched, return the default delivery charge
      rule&.delivery_charge || DEFAULT_DELIVERY_CHARGE
    end

    private

    def get_product_price(product_code)
      @catalogue.find!(product_code).price_cents
    end

    def find_matched_rule(items, total_price, total_items)
      applicable_rules = []

      applicable_rules.concat(find_total_based_rules(total_price))
      applicable_rules.concat(find_quantity_based_rules(total_items))
      applicable_rules.concat(find_product_based_rules(items, total_items))

      applicable_rules.compact.min_by(&:delivery_charge)
    end

    def find_total_based_rules(total_price)
      @rules.select do |rule|
        rule.product_code.nil? &&
          rule.min_total &&
          total_price >= rule.min_total
      end
    end

    def find_quantity_based_rules(total_items)
      @rules.select do |rule|
        rule.product_code.nil? &&
          rule.min_quantity &&
          total_items >= rule.min_quantity
      end
    end

    def find_product_based_rules(items, total_items)
      product_codes = items.map(&:product_code).uniq

      @rules.select do |rule|
        rule.product_code &&
          product_codes.include?(rule.product_code) &&
          rule.min_quantity &&
          total_items >= rule.min_quantity
      end
    end
  end
end
