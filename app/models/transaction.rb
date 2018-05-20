class Transaction < ApplicationRecord
  belongs_to :credit, class_name: "Account"
  belongs_to :debit, class_name: "Account"

  monetize :amount_cents

  def self.determine_accounts(amount, desc)
    if amount > 0
      debit = Account.where(code: 700).first
      credit = Filter.execute(desc)
    else        
      debit = Filter.execute(desc)
      credit = Account.where(code: 700).first
    end
    return debit,credit
  end
  
  def self.clear_and_load(file="#{Rails.root}/test/westpac_example.qif")
    Transaction.delete_all
    self.load(file)
  end

  def self.load(file="#{Rails.root}/test/westpac_example.qif")
    # Load the test data
    qif = Qif::Reader.new(open(file))

    qif.each do |tran|
      amount_cents = (tran.amount * 100)
      amount_cents * -1 if tran.category.length > 0
      desc = (tran.memo || tran.payee)
      debit,credit = self.determine_accounts(tran.amount, desc)

      # Create transaction
      Transaction.find_or_create_by(date: tran.date,
                                    description: desc,
                                    amount_cents: amount_cents,
                                    debit: debit,
                                    credit: credit)
    end
  end

  def self.refilter_common(trans)
    bank = Account.find_by_code(700)

    trans.each do |tran|
      debit, credit = self.determine_accounts(tran.amount, tran.description)

      tran.update_attributes({debit: debit, credit: credit})
    end
  end
  
  def self.refilter
    self.refilter_common(Transaction.all)
  end

  def self.refilter_sundries
    self.refilter_common(Transaction.where(debit_id: Account.find_by_code(999)))
    self.refilter_common(Transaction.where(credit_id: Account.find_by_code(999)))
  end
  
end

