# frozen_string_literal: true

module AcmeWidgetCo
  module Entity
    BasketTotal = Struct.new(:total, :delivery_charge, :discount, keyword_init: true)
  end
end
