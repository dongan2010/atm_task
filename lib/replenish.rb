class Replenish

  def call(banknotes_hash)
    banknotes = []
    banknotes_hash.each do |banknote_denomination, banknotes_count|
      banknotes_count.times do
        banknotes << CreateBanknote.call(banknote_denomination)
      end
    end
    InsertBanknotes.new.call(banknotes)
  end

end
