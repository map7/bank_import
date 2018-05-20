class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.all
  end

  def create
    binding.pry
  end

  def transaction_params
    params.require(:transaction).permit(:file_paths, :completed, :completed_filter)
  end
end
