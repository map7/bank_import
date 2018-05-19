class RemoveColumnCodeFromAccounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :code
  end
end
