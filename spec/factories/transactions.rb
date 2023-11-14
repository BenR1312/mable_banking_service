FactoryBot.define do
  factory :transaction do
    association :from_account, factory: :account
    association :to_account, factory: :account
    amount { 100.00 }
  end
end
