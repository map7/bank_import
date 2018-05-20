class AccountSummaryController < ApplicationController
  def index
    @accounts = Account.expense_chart
    render json: @accounts
  end

  def new
  end
end
