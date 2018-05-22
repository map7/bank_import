namespace :convert do
  desc "Convert to ledger_cli"
  task :ledger_cli => :environment do
    j = LedgerGen::Journal.build do |journal|
      Transaction.all.each do |tran|
        journal.transaction do |txn|
          txn.cleared!
          txn.date tran.date
          txn.payee tran.description
          txn.posting do |post|
            post.account "Expenses:#{tran.debit.name}"
            post.amount (tran.amount_cents / 100)
          end
          txn.posting "Assets:#{tran.credit.name}", -(tran.amount_cents / 100)
        end
      end
    end

    puts j.pretty_print
  end
end
