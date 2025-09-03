# frozen_string_literal: true

module AcmeWidgetCo
  module Entity
    Product = Struct.new(:code, :name, :price_cents, keyword_init: true)
  end
end
