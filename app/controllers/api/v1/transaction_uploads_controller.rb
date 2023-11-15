class Api::V1::TransactionUploadsController < ApplicationController
  def create
    service = TransactionUploadsService.new(transaction_upload_params[:file])

    if service.process
      render json: { data: { message: 'Transactions processed successfully' } }, status: :ok
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  private

  def transaction_upload_params
    params.permit(:file)
  end
end
