# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'minitest/autorun'
require 'minitest/parallel'
require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
end

require 'acme_widget_co'

module TestHelper
end
