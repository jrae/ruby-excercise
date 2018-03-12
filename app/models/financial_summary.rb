class FinancialSummary

  def initialize(transactions)
    @transactions = transactions
  end

  def self.one_day(args)
    new(
      all_transactions(args).days_before(Time.zone.now, 1)
    )
  end

  def self.seven_days(args)
    new(
      all_transactions(args).days_before(Time.zone.now, 7)
    )
  end

  def self.lifetime(args)
    new(all_transactions(args))
  end


  def count(category)
    within_category(category).count
  end

  def amount(category)
    within_category(category).collect(&:amount).sum
  end

  private

  def within_category(cat)
    @transactions.where(category: cat)
  end

  def self.all_transactions(args)
    # raise StandardError, 'Must provide currency to obtain financial summary' if args[:currency].blank?
    Transaction.where(
      user: args[:user],
      amount_currency: args[:currency].to_s.upcase
    )
  end
end
