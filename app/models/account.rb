class Account < ApplicationRecord
  has_many :debit_trans, class_name: "Transaction", foreign_key: "debit_id"
  has_many :credit_trans, class_name: "Transaction", foreign_key: "credit_id"
  has_many :filters

end
