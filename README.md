# ACME Widget Co

A test assignment for the ACME Widget Co.

## Task

See `TASK.md` for the task details.

## Running the tests

`bundle exec bin/test`

## Running the linter

`bundle exec rubocop`

## Running the formatter

`bundle exec rubocop --auto-correct-all`

## Assumptions

The solution assumes the following:

- It doesn't have any UI or framework dependencies, as it was mentioned in the task assignment.
- It doesn't have any storage and rely solely on the data passed in test fixtures.
- It doesn't use rails, as it doesn't need to be a web application and doesn't require any rails specific features.
- I decided to go with `minitest` instead of `rspec` as it suits the task requirements better due to simplicity.
- It uses the Strategy pattern to calculate the discount and the Rules pattern to calculate the delivery cost.
- The Strategy pattern works really well for the offers, as it is very flexible and allows to implement complex discount logic. In this solution, offers do not mutate the basket items, they only calculate the discount.
- The Rules pattern works great for the delivery cost calculation, in my opinion. It is easy to understand and follow the logic.

## Key components in AcmeWidgetCo module

### Classes

- `Basket` - The basket class that holds the products and calculates the total cost.
- `DeliveryCalculator` - The delivery calculator class that calculates the delivery cost based on the items in the basket and specified delivery rules. This component use the Rules pattern to calculate the delivery cost.
- `OfferEngine` - The offer engine class that calculates the discount based on the items in the basket. This component uses the Strategy pattern to calculate the discount.
- `Catalogue` - The catalogue class that holds the products.

### Entities (data structures)

- `Entity::BasketItem` - The basket item class that holds the product code and quantity.
- `Entity::BasketTotal` - The basket total class that holds the total cost, delivery cost and discount.
- `Entity::DeliveryRule` - The delivery rule class that holds the minimum total price, product code and minimum quantity.
- `Entity::Product` - The product class that holds the code, name and price.

### Offers

- `Offers::BuyOneRedGetHalf` - The buy one red widget get half price offer. This offer is a simple buy one get one free offer.
## Tests

- `test/basic_integration_test.rb` - The basic integration test that tests the basket with the basic catalogue. This test is based on the task requirements in `TASK.md`.
- `test/unit/delivery_calculator_test.rb` - The delivery calculator unit test that tests the delivery calculator class.
