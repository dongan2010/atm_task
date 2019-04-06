require 'spec_helper'

RSpec.describe Replenish do

  it 'creates baknotes' do
    banknotes_hash = { "1" => 2, "5" => 3, "50" => 1 }
    subject.call(banknotes_hash)
    expect(Banknote.count).to eql(6)
    expect(Banknote.where(denomination: "1").count).to eql(2)
    expect(Banknote.where(denomination: "5").count).to eql(3)
    expect(Banknote.where(denomination: "50").count).to eql(1)
  end

  it 'does not create baknotes for empty hash passed' do
    banknotes_hash = {}
    subject.call(banknotes_hash)
    expect(Banknote.count).to eql(0)
  end

  context 'if invalid denominations present in hash' do
    it 'does not fails and creates banknotes for valid denominations' do
      banknotes_hash = { "unused_denomination" => 3, "10" => 2 }
      subject.call(banknotes_hash)
      expect(Banknote.where(denomination: "10").count).to eql(2)
    end
  end

end
