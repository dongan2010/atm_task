class GetInfoAboutAllAvailableBanknotes

  def call
    Banknote.group(:denomination).count
  end

end
