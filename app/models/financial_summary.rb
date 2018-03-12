class FinancialSummary

  attr_reader :user, :currency, :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def self.one_day(args)
    new(
      Transaction.where(
        user: args[:user],
        amount_currency: args[:currency].to_s.upcase
      ).days_before(Time.zone.now, 1)
    )
  end

  def within_category(cat)
    @transactions.where(category: cat)
  end

  def count(category)
    within_category(category).count
  end

  def amount(category)
    within_category(category).collect(&:amount).sum
  end
end
