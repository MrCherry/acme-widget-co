# frozen_string_literal: true

module AcmeWidgetCo
  # Catalogue for the ACME Widget Co
  class Catalogue
    attr_reader :products

    def initialize(products:)
      @products = products
    end

    def find(product_code)
      @products.find { |product| product.code == product_code }
    end

    def find!(product_code)
      find(product_code) || raise(StandardError, "Product #{product_code} not found")
    end
  end
end
