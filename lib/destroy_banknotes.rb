class DestroyBanknotes

  def call(denominations_to_give)
    records = []

    denominations_to_give.each do |denomination, count|
      records << Banknote.where(denomination: denomination).limit(count).all
    end

    Banknote.delete(records.flatten.map(&:id))
  end

end
