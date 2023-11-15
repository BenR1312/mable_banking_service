# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

[
  [1111234522226789,5000.00],
  [1111234522221234,10000.00],
  [2222123433331212,550.00],
  [1212343433335665,1200.00],
  [3212343433335755,50000.00]
].each do |account_number, balance|
  Account.find_or_create_by!(account_number:, balance:)
end
