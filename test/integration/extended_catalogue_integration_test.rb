# frozen_string_literal: true

require 'test_helper'

class ExtendedCatalogueIntegrationTest < Minitest::Test
  include BasketFactory

  def setup
    @catalogue = CatalogueLoader.load_extended_catalogue
    @basket = create_basket_with_extended_catalogue
  end

  def test_extended_catalogue_loading
    # Test that we can load products from the extended catalogue
    refute_nil @catalogue, 'Should load extended catalogue'
    assert @catalogue.products.any?, 'Should have products in extended catalogue'
  end

  def test_catalogue_find_product
    # Test finding products in the extended catalogue
    purple_widget = @catalogue.find('P01')
    refute_nil purple_widget, 'Should find Purple Widget (P01) in extended catalogue'
    assert_equal 'Purple Widget', purple_widget.name
    assert_equal 1095, purple_widget.price_cents
  end

  def test_basket_with_extended_products
    # Test creating a basket with products from extended catalogue
    @basket.add('P01') # Purple Widget
    @basket.add('Y01') # Yellow Widget

    result = @basket.total

    # P01 ($10.95) + Y01 ($8.95) = $19.90 + $4.95 delivery = $24.85
    assert_equal 2485, result.total, 'Should calculate total correctly with extended catalogue products'
    assert_equal 495, result.delivery_charge, 'Should apply correct delivery charge'
    assert_equal 0, result.discount, 'Should not apply discount to non-offer products'
  end

  def test_offer_compatibility_with_extended_catalogue
    # Test that offers still work with extended catalogue (if it has R01)
    red_widget = @catalogue.find('R01')
    if red_widget
      @basket.add('R01')
      @basket.add('R01')

      result = @basket.total

      # Should still apply red widget offer if R01 exists in extended catalogue
      assert result.discount.positive?, 'Should apply red widget discount if R01 exists in extended catalogue'
    else
      skip 'R01 not found in extended catalogue, skipping offer test'
    end
  end

  def test_basket_with_extended_products_and_offers
    # Test creating a basket with products from extended catalogue and offers
    @basket.add('P01') # Purple Widget
    @basket.add('Y01') # Yellow Widget
    @basket.add('O01') # Orange Widget
    @basket.add('W01') # White Widget
    @basket.add('B02') # Brown Widget
    @basket.add('P02') # Pink Widget
    @basket.add('G02') # Gray Widget

    result = @basket.total

    # P01 ($10.95) + Y01 ($8.95) + O01 ($12.95) + W01 ($14.95) + B02 ($7.95) + P02 ($18.95) + G02 ($20.95) = $104.65
    # $104.65 - 10% discount ($10.46) = $94.18
    # Delivery is free because the total is over $90
    assert_equal 9418, result.total, 'Should calculate total correctly with extended catalogue products and offers'
    assert_equal 0, result.delivery_charge, 'Should apply free delivery'
    assert_equal 1046, result.discount, 'Should apply 10% discount'
  end

  private

  def create_basket_with_extended_catalogue
    offers = [
      AcmeWidgetCo::Offers::BuyOneRedGetHalf.new,
      AcmeWidgetCo::Offers::BulkDiscount.new,
      AcmeWidgetCo::Offers::GreenBlueBundle.new
    ]
    create_basket_with_offers(@catalogue, offers)
  end
end
