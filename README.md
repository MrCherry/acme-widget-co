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

## Key components in AcmeWidgetCo module

### Classes

- `Basket` - The basket class that holds the products and calculates the total cost.
- `Catalogue` - The catalogue class that holds the products.

### Entities (data structures)

- `Entity::BasketItem` - The basket item class that holds the product code and quantity.
- `Entity::BasketTotal` - The basket total class that holds the total cost, delivery cost and discount.
- `Entity::Product` - The product class that holds the code, name and price.
