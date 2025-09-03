# frozen_string_literal: true

require 'test_helper'

class OffersTest < Minitest::Test
  def setup
    @catalogue = CatalogueLoader.load_basic_catalogue
  end

  # Test BuyOneRedGetHalf offer
  def test_buy_one_red_get_half_with_two_red_widgets
    offer = AcmeWidgetCo::Offers::BuyOneRedGetHalf.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'R01', quantity: 2)
    ]

    assert offer.applicable?(items, @catalogue), 'Should be applicable with 2 red widgets'

    discount = offer.calculate_discount(items, @catalogue)
    expected_discount = (3295 / 2.0).round(2) # 50% off one red widget
    assert_equal expected_discount, discount, 'Should discount 50% of one red widget'
  end

  def test_buy_one_red_get_half_with_one_red_widget
    offer = AcmeWidgetCo::Offers::BuyOneRedGetHalf.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'R01', quantity: 1)
    ]

    refute offer.applicable?(items, @catalogue), 'Should not be applicable with only 1 red widget'

    discount = offer.calculate_discount(items, @catalogue)
    assert_equal 0, discount, 'Should not apply discount with only 1 red widget'
  end

  def test_buy_one_red_get_half_with_three_red_widgets
    offer = AcmeWidgetCo::Offers::BuyOneRedGetHalf.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'R01', quantity: 3)
    ]

    assert offer.applicable?(items, @catalogue), 'Should be applicable with 3 red widgets'

    discount = offer.calculate_discount(items, @catalogue)
    expected_discount = (3295 / 2.0).round(2) # 50% off one red widget (3/2 = 1 pair)
    assert_equal expected_discount, discount, 'Should discount 50% of one red widget for 3 widgets'
  end

  # Test BulkDiscount offer
  def test_bulk_discount_with_five_items
    offer = AcmeWidgetCo::Offers::BulkDiscount.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'B01', quantity: 5)
    ]

    assert offer.applicable?(items, @catalogue), 'Should be applicable with 5 items'

    discount = offer.calculate_discount(items, @catalogue)
    subtotal = 795 * 5 # 5 blue widgets
    expected_discount = (subtotal * 0.10).round(2)
    assert_equal expected_discount, discount, 'Should apply 10% discount on 5 items'
  end

  def test_bulk_discount_with_four_items
    offer = AcmeWidgetCo::Offers::BulkDiscount.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'B01', quantity: 4)
    ]

    refute offer.applicable?(items, @catalogue), 'Should not be applicable with only 4 items'

    discount = offer.calculate_discount(items, @catalogue)
    assert_equal 0, discount, 'Should not apply discount with only 4 items'
  end

  # Test GreenBlueBundle offer
  def test_green_blue_bundle_with_one_each
    offer = AcmeWidgetCo::Offers::GreenBlueBundle.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'G01', quantity: 1),
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'B01', quantity: 1)
    ]

    assert offer.applicable?(items, @catalogue), 'Should be applicable with green and blue widgets'

    discount = offer.calculate_discount(items, @catalogue)
    assert_equal 500, discount, 'Should apply $5.00 discount for green+blue bundle'
  end

  def test_green_blue_bundle_with_multiple_bundles
    offer = AcmeWidgetCo::Offers::GreenBlueBundle.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'G01', quantity: 2),
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'B01', quantity: 3)
    ]

    assert offer.applicable?(items, @catalogue), 'Should be applicable with multiple green and blue widgets'

    discount = offer.calculate_discount(items, @catalogue)
    # 2 complete bundles (limited by green widgets)
    assert_equal 1000, discount, 'Should apply $10.00 discount for 2 green+blue bundles'
  end

  def test_green_blue_bundle_with_only_green
    offer = AcmeWidgetCo::Offers::GreenBlueBundle.new
    items = [
      AcmeWidgetCo::Entity::BasketItem.new(product_code: 'G01', quantity: 2)
    ]

    refute offer.applicable?(items, @catalogue), 'Should not be applicable with only green widgets'

    discount = offer.calculate_discount(items, @catalogue)
    assert_equal 0, discount, 'Should not apply discount without blue widgets'
  end
end
