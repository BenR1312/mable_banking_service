class Transaction < ApplicationRecord
  # Associations
  belongs_to :from_account,
             class_name: 'Account',
             inverse_of: :sent_transactions

  belongs_to :to_account,
             class_name: 'Account',
             inverse_of: :received_transactions

  # Validations
  validates :amount, numericality: { greater_than: 0 }
  validate :sufficient_funds

  private

  def sufficient_funds
    return if amount.blank? || from_account.blank?

    errors.add(:amount, 'exceeds available balance') if from_account.balance < amount
  end
end
