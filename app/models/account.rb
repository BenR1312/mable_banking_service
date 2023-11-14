class Account < ApplicationRecord
  # Associations
  has_many :sent_transactions,
           class_name: 'Transaction',
           foreign_key: 'from_account_id',
           dependent: :destroy,
           inverse_of: :from_account

  has_many :received_transactions,
           class_name: 'Transaction',
           foreign_key: 'to_account_id',
           dependent: :destroy,
           inverse_of: :to_account

  # Validations
  validates :account_number,
            presence: true,
            uniqueness: true,
            length: { is: 16 }
  validates :balance,
            numericality: { greater_than_or_equal_to: 0 }
end
