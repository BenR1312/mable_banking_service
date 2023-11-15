require 'csv'

class TransactionUploadsService
  attr_reader :errors

  def initialize(file)
    @file = file
    @errors = []
  end

  def process
    return false unless @file

    CSV.foreach(@file.path, headers: false).with_index(1) do |row, line_number|
      record = process_row(row)

      next if record.valid?

      @errors << { line: line_number, error: record.errors.full_messages.join(', ') }
    end

    @errors.empty?
  end

  private

  def process_row(row)
    # assumption is first column is from_account, second column is to_account, third column is amount
    Transaction.create(
      from_account: Account.find_by(account_number: row[0]),
      to_account: Account.find_by(account_number: row[1]),
      amount: row[2]
    )
  end
end
