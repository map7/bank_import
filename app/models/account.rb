class Account < ApplicationRecord
  has_many :debit_trans, class_name: "Transaction", foreign_key: "debit_id"
  has_many :credit_trans, class_name: "Transaction", foreign_key: "credit_id"
  has_many :filters

  def self.summary
    results = []
    Account.all.each do |acc|
      expenses = acc.credit_trans.sum(:amount_cents) / 100
      income = acc.debit_trans.sum(:amount_cents) / 100

      if expenses < 0 or income > 0
        results << {name: acc.name, expenses: expenses, income: income}
      end
    end
    results
  end
  
end
