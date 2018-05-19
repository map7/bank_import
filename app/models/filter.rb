class Filter < ApplicationRecord
  belongs_to :account

  def self.execute(text)
    matched_account = Account.where(code: 999).first
    # For the current transaction step through each filter
    Filter.all.each do |filter|

      # Check for a match
      if text.match(/#{filter.keyword}/)
        matched_account = filter.account
      end
    end

    return matched_account
  end
end
