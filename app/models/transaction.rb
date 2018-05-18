class Transaction < ApplicationRecord
  belongs_to :credit, class_name: "Account"
  belongs_to :debit, class_name: "Account"
end
