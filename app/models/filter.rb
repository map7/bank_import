class Filter < ApplicationRecord
  belongs_to :account

  def self.execute(text)
    text.split().each do |token|
      Filter.all.each do |filter|
        if token == filter.keyword
          return filter.account
        end
      end
    end

    return Account.where(code: 999).first
  end
end
