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
end
