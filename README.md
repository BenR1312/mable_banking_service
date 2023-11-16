# Mable Banking Service

## Description

This is a simple banking api service that allows the processing of transactions between accounts.  
Only processing Transactions via a csv file being passed to the API will be allowed, any other actions will not be supported such as creating new accounts.  
No UI exists for this application, if a UI is desired please reach out and i will happily make some changes to support a ui.  

The api response will include relevant lines that have issues on them that need to be resolved, this response could easily be used to display to a user what lines need to be fixed and re-submitted, all other lines will have been processed successfully.  
Otherwise you will see a happy response.  
Api response format follows [json api spec](https://jsonapi.org/) standards.

example response with errors:

```json
{
    "errors": [
        {
            "line": 1,
            "error": "Amount exceeds available balance"
        }
    ]
}
```

example response with no errors:

```json
{
    "message": "All transactions processed successfully"
}
```

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

For api documentation please use the postman collection [here](https://github.com/BenR1312/mable_banking_service/blob/main/api_documentation_postman_collection.json)
Please use the [mable_trans.csv](https://github.com/BenR1312/mable_banking_service/blob/main/mable_trans.csv) file in the root of the project to test the api.

## Running Tests

Please simply run and you will see test results along with simplecov coverage report:

```bash
bundle exec rspec
```
