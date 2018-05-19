class Transaction < ApplicationRecord
  belongs_to :credit, class_name: "Account"
  belongs_to :debit, class_name: "Account"

  def self.load
    qif = Qif::Reader.new(open("#{Rails.root}/test/testdata.qif"))
    debit = Account.where(code: 700).first
    credit = Account.where(code: 999).first
    
    qif.each do |tran|
      new_transaction = Transaction.new(date: tran.date,
                                        description: tran.memo,
                                        amount_cents: (tran.amount * 100),
                                        debit: debit,
                                        credit: credit)
      new_transaction.save
    end
  end
end

