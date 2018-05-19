class AddColumnCodeToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :code, :integer
  end
end
