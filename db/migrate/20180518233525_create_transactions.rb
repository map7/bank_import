class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.string :description
      t.integer :amount_cents
      t.integer :debit_id
      t.integer :credit_id

      t.timestamps
    end
  end
end
