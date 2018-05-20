class Filter < ApplicationRecord
  belongs_to :account

  def self.execute(text)
    Filter.all.each do |filter|
      if text.match(/#{filter.phrase}/i) and !filter.phrase.blank?
        return filter.account
      end
    end

    text.split().each do |token|
      Filter.all.each do |filter|
        if token.try(:downcase) == filter.keyword.try(:downcase)
          return filter.account
        end
      end
    end

    return Account.where(code: 999).first
  end
end
