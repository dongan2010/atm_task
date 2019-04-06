class CreateCashOut

  def call(amount)
    available_banknotes_info = GetInfoAboutAllAvailableBanknotes.new.call
    needed_denominations_for_cash_out = CalculateDenominationsNeeded.new.call(available_banknotes_info: available_banknotes_info, value_to_cash_out: amount)
    DestroyBanknotes.new.call(needed_denominations_for_cash_out)

    needed_denominations_for_cash_out
  end

end
