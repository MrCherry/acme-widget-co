# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'minitest/autorun'
require 'minitest/parallel'
require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
end

require 'acme_widget_co'
require_relative 'support/catalogue_loader'
require_relative 'support/basket_factory'

module TestHelper
  module_function

  def fixture_path
    File.expand_path('fixtures', __dir__)
  end
end
