# frozen_string_literal: true

module AcmeWidgetCo
  # Basket for the ACME Widget Co
  # Calculates the total cost of the basket and returns the total cost, delivery charge and discount
  class Basket
    attr_reader :items

    def initialize(catalogue:, offer_engine:, delivery_calculator:)
      @items = []
      @catalogue = catalogue
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
      
      Entity::BasketTotal.new(
        total: 0,
        delivery_charge: 0,
        discount: 0
      )
    end
  end
end
