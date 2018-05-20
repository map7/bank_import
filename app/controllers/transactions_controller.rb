class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.all
  end

  def create
    file_path = transaction_params[:file_paths].tempfile.path
    full_path = Rails.root.join(file_path).to_s
    # Send file paths to load transaction method
    Transaction.load(full_path)
    redirect_to new_account_summary_path
  end

  def destroy_many
    Transaction.delete_all
  end

  def transaction_params
    params.require(:transaction).permit(:file_paths, :completed, :completed_filter)
  end
end
