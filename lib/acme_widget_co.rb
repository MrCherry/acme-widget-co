# frozen_string_literal: true

# Entity models
require_relative 'acme_widget_co/entity/product'
require_relative 'acme_widget_co/entity/basket_item'
require_relative 'acme_widget_co/entity/basket_total'
require_relative 'acme_widget_co/entity/delivery_rule'

# Core classes
require_relative 'acme_widget_co/catalogue'
require_relative 'acme_widget_co/basket'
require_relative 'acme_widget_co/delivery_calculator'

# Offer system
require_relative 'acme_widget_co/offers/base_offer'
require_relative 'acme_widget_co/offers/buy_one_red_get_half'
require_relative 'acme_widget_co/offer_engine'

# The main module for the ACME Widget Co.
module AcmeWidgetCo
end
