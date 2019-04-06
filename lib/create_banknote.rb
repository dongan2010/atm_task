class CreateBanknote

  def self.call(denomination)
    Banknote.new(denomination: denomination)
  end

end
