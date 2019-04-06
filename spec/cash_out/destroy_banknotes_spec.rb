require 'spec_helper'

RSpec.describe DestroyBanknotes do

  it 'corectly calculates denominations' do
    Banknote.create(denomination: 1)

    result = subject.call({ 1=>1 })

    expect(Banknote.count).to eql(0)
  end

end
