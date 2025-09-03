# frozen_string_literal: true

module AcmeWidgetCo
  module Entity
    BasketItem = Struct.new(:product_code, :quantity, keyword_init: true)
  end
end
