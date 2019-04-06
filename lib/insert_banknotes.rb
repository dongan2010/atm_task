class InsertBanknotes

  def call(banknotes)
    Banknote.import(banknotes)
  end

end
