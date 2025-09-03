# frozen_string_literal: true

module AcmeWidgetCo
  # Basket for the ACME Widget Co
  # Calculates the total cost of the basket and returns the total cost, delivery charge and discount
  class Basket
    attr_reader :items

    def initialize(catalogue:, offer_engine:, delivery_calculator:)
      @items = []
      @catalogue = catalogue
      @delivery_calculator = delivery_calculator
    end

    def add(product_code)
      product = @catalogue.find!(product_code)
      product_in_basket = @items.find { |item| item.product_code == product.code }

      if product_in_basket
        product_in_basket.quantity += 1
      else
        @items << Entity::BasketItem.new(product_code: product.code, quantity: 1)
      end
    end

    def total
      subtotal = calculate_subtotal
      delivery_charge = @delivery_calculator.calculate_for_total(@items, subtotal)

      total_amount = subtotal_after_discount + delivery_charge
      
      Entity::BasketTotal.new(
        total: total_amount,
        delivery_charge: delivery_charge,
        discount: 0
      )
    end

    private

    def calculate_subtotal
      @items.sum do |item|
        product_price = @catalogue.find!(item.product_code).price_cents
        product_price * item.quantity
      end
    end
  end
end
