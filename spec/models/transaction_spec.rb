RSpec.describe Transaction, type: :model do
  describe 'validations' do
    subject(:transaction) do
      build(:transaction, from_account:, to_account:, amount:)
    end

    let(:from_account) { create(:account, balance: 100) }
    let(:to_account) { create(:account) }
    let(:amount) { 100.00 }

    it 'is valid with valid attributes' do
      expect(transaction).to be_valid
    end

    context 'when txn is not valid without an amount' do
      let(:amount) { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when txn is not valid with a negative amount' do
      let(:amount) { -100.00 }

      it { is_expected.not_to be_valid }
    end

    context 'is not valid if from_account does not have enough balance' do
      let(:from_account) { create(:account, balance: 50) }
      let(:amount) { 100 }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'associations' do
    it 'belongs to a from_account' do
      expect(described_class.reflect_on_association(:from_account).macro).to eq(:belongs_to)
    end

    it 'belongs to a to_account' do
      expect(described_class.reflect_on_association(:to_account).macro).to eq(:belongs_to)
    end
  end

  describe '#process_transaction' do
    subject(:transaction) { build(:transaction, from_account:, to_account:, amount:) }

    context 'when the transaction is successfully created' do
      let(:from_account) { create(:account, balance: 1000) }
      let(:to_account) { create(:account, balance: 500) }
      let(:amount) { 100 }

      it 'deducts the amount from the from_account' do
        transaction.save
        expect(transaction.from_account.reload.balance.to_i).to eq(900)  # 1000 - 100
      end

      it 'adds the amount to the to_account' do
        transaction.save
        expect(transaction.to_account.reload.balance).to eq(600)  # 500 + 100
      end
    end

    context 'when the transaction fails due to insufficient funds' do
      let!(:from_account) { create(:account, balance: 50) }
      let!(:to_account) { create(:account, balance: 500) }
      let(:amount) { 100 }

      it 'does not create a transaction' do
        expect { transaction.save }.not_to change(Transaction, :count)
      end

      it 'does not change the balance of the from_account' do
        expect { transaction.save }.not_to(change { from_account.reload.balance })
      end

      it 'does not change the balance of the to_account' do
        expect { transaction.save }.not_to(change { to_account.reload.balance })
      end
    end
  end
end
