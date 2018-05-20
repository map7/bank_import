class AccountSummaryController < ApplicationController
  def index
    @accounts = Account.expense_chart
    render json: @accounts
  end
end
