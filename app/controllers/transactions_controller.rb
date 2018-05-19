class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.all
  end
end
