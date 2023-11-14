# Mable Banking Service

## Description

This is a simple banking service that allows the processing of transactions between accounts.
Only processing Transactions via a csv file being passed to the API will be allowed, any other actions will not be supported such as creating new accounts.

## Requirements

* Ruby 3.2.2
* Rails 7.1.2

## Getting Started

Simply run:

```bash
bin/setup
```

This will install all the dependencies and setup the database.
This will also run the [seeds](https://github.com/BenR1312/mable_banking_service/blob/main/db/seeds.rb) file to create the accounts.

To run the application please run:

```bash
rails s
```

For api documentation please use the postman collection here

## Running Tests

Please simply run:

```bash
bundle exec rspec
```
