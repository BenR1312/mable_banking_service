FactoryBot.define do
  factory :account do
    sequence(:account_number) { |n| "000000000000000#{n}".last(16) }
    balance { 1000.00 }
  end
end
