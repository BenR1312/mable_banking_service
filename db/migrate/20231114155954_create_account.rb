class CreateAccount < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :account_number, limit: 16, null: false
      t.decimal :balance, precision: 15, scale: 2, null: false, default: 0

      t.timestamps
    end
    add_index :accounts, :account_number, unique: true
  end
end
