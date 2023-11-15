require 'rails_helper'

RSpec.describe 'TransactionsUploads', type: :request do
  describe 'POST /transactions_upload' do
    let(:valid_file) { fixture_file_upload('valid_transactions.csv', 'text/csv') }
    let(:invalid_file) { fixture_file_upload('invalid_transactions.csv', 'text/csv') }

    let!(:account_one) { create(:account, account_number: 1234123412341234) }
    let!(:account_two) { create(:account, account_number: 4321432143214321) }

    context 'with valid CSV file' do
      it 'processes the file and returns a success message' do
        post api_v1_transaction_uploads_path, params: { file: valid_file }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data']['message']).to eq('Transactions processed successfully')
      end
    end

    context 'with invalid CSV file' do
      it 'returns an error message' do
        post api_v1_transaction_uploads_path, params: { file: invalid_file }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end
end
