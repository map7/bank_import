class Transaction < ApplicationRecord
  belongs_to :credit, class_name: "Account"
  belongs_to :debit, class_name: "Account"

  monetize :amount_cents
  
  def self.load(file="#{Rails.root}/test/testdata.qif")
    # Clear the db
    Transaction.delete_all

    # Load the test data
    qif = Qif::Reader.new(open(file))

    qif.each do |tran|
      # Determine if it's a debit or credit
      if tran.category == "DEBIT"
        debit = Account.where(code: 700).first
        credit = Account.where(code: 999).first
      else        
        credit = Account.where(code: 700).first
        debit = Account.where(code: 999).first
      end

      # Create transaction
      new_transaction = Transaction.new(date: tran.date,
                                        description: (tran.memo || tran.payee),
                                        amount_cents: (tran.amount * 100),
                                        debit: debit,
                                        credit: credit)
      new_transaction.save
    end
  end
end

