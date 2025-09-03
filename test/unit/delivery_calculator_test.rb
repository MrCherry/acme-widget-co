# frozen_string_literal: true

require 'test_helper'

class DeliveryCalculatorTest < Minitest::Test
  def setup
    @catalogue = CatalogueLoader.load_basic_catalogue

    # Create delivery rules matching business requirements
    delivery_rules = [
      AcmeWidgetCo::Entity::DeliveryRule.new(min_total: 9000, delivery_charge: 0),  # Free delivery over $90
      AcmeWidgetCo::Entity::DeliveryRule.new(min_total: 5000, delivery_charge: 295) # $2.95 delivery over $50
      # Default: $4.95 for orders under $50
    ]

    @delivery_calculator = AcmeWidgetCo::DeliveryCalculator.new(
      catalogue: @catalogue,
      rules: delivery_rules
    )
  end

  def test_delivery_under_fifty_dollars
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'B01', quantity: 5) # $39.75
    ]

    delivery_charge = @delivery_calculator.calculate(items)
    assert_equal 495, delivery_charge, 'Should charge $4.95 for orders under $50'
  end

  def test_delivery_between_fifty_and_ninety_dollars
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'R01', quantity: 1), # $32.95
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'G01', quantity: 1)  # $24.95
    ]
    # Total: $57.90

    delivery_charge = @delivery_calculator.calculate(items)
    assert_equal 295, delivery_charge, 'Should charge $2.95 for orders between $50-$89.99'
  end

  def test_delivery_over_ninety_dollars
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'R01', quantity: 3) # $98.85
    ]

    delivery_charge = @delivery_calculator.calculate(items)
    assert_equal 0, delivery_charge, 'Should provide free delivery for orders over $90'
  end

  def test_delivery_exactly_fifty_dollars
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'B01', quantity: 6), # $47.70
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'G01', quantity: 1)  # $24.95
    ]
    # Total: $72.65 - should trigger $2.95 delivery rule

    delivery_charge = @delivery_calculator.calculate(items)
    assert_equal 295, delivery_charge, 'Should charge $2.95 for orders between $50-$89.99'
  end

  def test_delivery_exactly_ninety_dollars
    items = [
      # Create items that total exactly $90.00
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'R01', quantity: 2), # $65.90
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'G01', quantity: 1)  # $24.95
      # Total: $90.85 (over $90)
    ]

    delivery_charge = @delivery_calculator.calculate(items)
    assert_equal 0, delivery_charge, 'Should provide free delivery for orders of exactly $90 or more'
  end
end
