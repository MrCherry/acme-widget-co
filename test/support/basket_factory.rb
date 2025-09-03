# frozen_string_literal: true

module BasketFactory
  def create_basket_with_offers(catalogue, offers)
    delivery_calculator = create_delivery_calculator(catalogue)
    offer_engine = create_offer_engine(catalogue, offers)

    AcmeWidgetCo::Basket.new(
      catalogue: catalogue,
      offer_engine: offer_engine,
      delivery_calculator: delivery_calculator
    )
  end

  def create_delivery_calculator(catalogue)
    rules = [
      AcmeWidgetCo::Entity::DeliveryRule.new(min_total: 9000, delivery_charge: 0),
      AcmeWidgetCo::Entity::DeliveryRule.new(min_total: 5000, delivery_charge: 295)
    ]
    AcmeWidgetCo::DeliveryCalculator.new(catalogue: catalogue, rules: rules)
  end

  def create_offer_engine(catalogue, offers)
    AcmeWidgetCo::OfferEngine.new(catalogue: catalogue, offers: offers)
  end
end
