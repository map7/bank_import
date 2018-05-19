class Transaction < ApplicationRecord
  belongs_to :credit, class_name: "Account"
  belongs_to :debit, class_name: "Account"

  monetize :amount_cents
  
  def self.load(file="#{Rails.root}/test/westpac_example.qif")
    # Clear the db
    Transaction.delete_all

    # Load the test data
    qif = Qif::Reader.new(open(file))

    qif.each do |tran|
      
      desc = (tran.memo || tran.payee)
      
      # Determine if it's a debit or credit
      if tran.category == "DEBIT"
        debit = Account.where(code: 700).first
        credit = Filter.execute(desc)
      else        
        credit = Account.where(code: 700).first
        debit = Filter.execute(desc)
      end

      # Create transaction
      new_transaction = Transaction.new(date: tran.date,
                                        description: desc,
                                        amount_cents: (tran.amount * 100),
                                        debit: debit,
                                        credit: credit)
      new_transaction.save

      byebug
    end
  end
  
end

