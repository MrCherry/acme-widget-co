# frozen_string_literal: true

require 'yaml'

module CatalogueLoader
  module_function

  def load_basic_catalogue
    load_catalogue_from_file('catalogue-basic.yaml')
  end

  def load_extended_catalogue
    load_catalogue_from_file('catalogue-extended.yaml')
  end

  def load_catalogue_from_file(filename)
    filepath = File.join(TestHelper.fixture_path, filename)
    data = YAML.load_file(filepath)

    products = data['products'].map do |product_data|
      AcmeWidgetCo::Entity::Product.new(
        code: product_data['code'],
        name: product_data['name'],
        price_cents: product_data['price_cents']
      )
    end

    AcmeWidgetCo::Catalogue.new(products: products)
  end
end
