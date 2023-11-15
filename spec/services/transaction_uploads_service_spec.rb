require 'rails_helper'

RSpec.describe TransactionUploadsService do
  describe '#process' do
    subject(:service) { TransactionUploadsService.new(file) }

    let!(:account_one) { create(:account, account_number: 1234123412341234) }
    let!(:account_two) { create(:account, account_number: 4321432143214321) }

    context 'when file is valid' do
      let(:file) { fixture_file_upload('valid_transactions.csv', 'text/csv') }

      it 'processes all rows successfully' do
        expect(service.process).to be true
        expect(service.errors).to be_empty
      end
    end

    context 'when file has invalid data' do
      let(:file) { fixture_file_upload('invalid_transactions.csv', 'text/csv') }

      it 'captures errors for invalid rows' do
        expect(service.process).to be false
        expect(service.errors).not_to be_empty
        expect(service.errors).to eq(
          [
            { error: 'To account must exist', line: 1 },
            { error: 'From account must exist', line: 2 },
            { error: 'Amount is not a number', line: 3 },
            { error: 'Amount must be greater than 0', line: 4 }
          ]
        )
      end
    end

    context 'when file has partial valid and invalid data' do
      let(:file) { fixture_file_upload('partial_valid_and_invalid_transactions.csv', 'text/csv') }

      it 'captures errors for invalid rows and processes the remainer' do
        expect(service.process).to be false
        expect(service.errors).not_to be_empty
        expect(service.errors).to eq(
          [
            { error: 'Amount must be greater than 0', line: 2 }
          ]
        )
        expect(Transaction.count).to eq(2)
        expect(Transaction.last).to have_attributes(
          from_account_id: account_one.id,
          to_account_id: account_two.id,
          amount: 100
        )
      end
    end
  end
end
