class Transaction < ApplicationRecord
  belongs_to :credit, class_name: "Account"
  belongs_to :debit, class_name: "Account"

  monetize :amount_cents

  def self.determine_accounts(category, desc)
    if category == "DEBIT"
      debit = Account.where(code: 700).first
      credit = Filter.execute(desc)
    else        
      credit = Account.where(code: 700).first
      debit = Filter.execute(desc)
    end
    return debit,credit
  end
  
  def self.clear_and_load(file)
    Transaction.delete_all
    self.load(file)
  end

  def self.load(file="#{Rails.root}/test/westpac_example.qif")
    # Load the test data
    qif = Qif::Reader.new(open(file))

    qif.each do |tran|
      
      desc = (tran.memo || tran.payee)
      debit,credit = self.determine_accounts(tran.category, desc)

      # Create transaction
      Transaction.find_or_create_by(date: tran.date,
                                    description: desc,
                                    amount_cents: (tran.amount * 100),
                                    debit: debit,
                                    credit: credit)
    end
  end
  
end

