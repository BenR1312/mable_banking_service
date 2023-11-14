RSpec.describe Account, type: :model do
  describe 'validations' do
    subject(:account) { build(:account, account_number:, balance:) }

    let(:balance) { 1000.00 }
    let(:account_number) { '1234567890123456' }

    it 'is valid with valid attributes' do
      expect(account).to be_valid
    end

    context 'when not valid without an account number' do
      let(:account_number) { nil }

      it { is_expected.not_to be_valid }
    end

    context 'when existing account number is present' do
      before { create(:account, account_number:) }

      it { is_expected.not_to be_valid }
    end

    context 'when account number is not 16 characters long' do
      let(:account_number) { '123' }

      it { is_expected.not_to be_valid }
    end

    context 'when balance is negative' do
      let(:balance) { -1000.00 }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'associations' do
    it 'has many sent_transactions' do
      expect(described_class.reflect_on_association(:sent_transactions).macro).to eq(:has_many)
    end

    it 'has many received_transactions' do
      expect(described_class.reflect_on_association(:received_transactions).macro).to eq(:has_many)
    end
  end
end
