# frozen_string_literal: true

require 'test_helper'

class BasicIntegrationTest < Minitest::Test
  include BasketFactory

  def setup
    @catalogue = CatalogueLoader.load_basic_catalogue
    @basket = create_basket
  end

  # Test cases from TASK.md - these are the official requirements
  def test_basket_b01_g01_total
    @basket.add('B01')
    @basket.add('G01')
    result = @basket.total

    # B01 ($7.95) + G01 ($24.95) = $32.90 + $4.95 delivery = $37.85
    assert_equal 3785, result.total, 'Expected total $37.85 for B01, G01'
    assert_equal 495, result.delivery_charge, 'Expected $4.95 delivery charge'
    assert_equal 0, result.discount, 'Expected no discount'
  end

  def test_basket_r01_r01_total
    @basket.add('R01')
    @basket.add('R01')
    result = @basket.total

    # R01 ($32.95) + R01 ($16.47 with 50% off) = $49.43 + $4.95 delivery = $54.37
    assert_equal 5437, result.total, 'Expected total $54.37 for R01, R01'
    assert_equal 495, result.delivery_charge, 'Expected $4.95 delivery charge'
    assert_equal 1647, result.discount, 'Expected $16.47 discount (50% off second red widget)'
  end

  def test_basket_r01_g01_total
    @basket.add('R01')
    @basket.add('G01')
    result = @basket.total

    # R01 ($32.95) + G01 ($24.95) = $57.90 + $2.95 delivery = $60.85
    assert_equal 6085, result.total, 'Expected total $60.85 for R01, G01'
    assert_equal 295, result.delivery_charge, 'Expected $2.95 delivery charge (over $50)'
    assert_equal 0, result.discount, 'Expected no discount (only one red widget)'
  end

  def test_basket_b01_b01_r01_r01_r01_total
    @basket.add('B01')
    @basket.add('B01')
    @basket.add('R01')
    @basket.add('R01')
    @basket.add('R01')
    result = @basket.total

    # B01 ($7.95) + B01 ($7.95) + R01 ($32.95) + R01 ($16.47) + R01 ($32.95) = $98.27
    assert_equal 9827, result.total, 'Expected total $98.27 for B01, B01, R01, R01, R01'
    assert_equal 0, result.delivery_charge, 'Expected free delivery (over $90)'
    assert_equal 1647, result.discount, 'Expected $16.47 discount (red widget offer)'
  end

  private

  def create_basket
    offers = [AcmeWidgetCo::Offers::BuyOneRedGetHalf.new]
    create_basket_with_offers(@catalogue, offers)
  end
end
