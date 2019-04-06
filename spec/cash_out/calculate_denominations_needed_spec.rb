require 'spec_helper'

RSpec.describe CalculateDenominationsNeeded do

  let(:available_banknotes_info) { { 1=>2, 5=>3, 50=>1 } }

  it 'corectly calculates denominations' do
    result = subject.call(available_banknotes_info: available_banknotes_info, value_to_cash_out: 57)
    expect(result).to eql({ 50=>1, 5=>1, 1=>2 })

    result = subject.call(available_banknotes_info: available_banknotes_info, value_to_cash_out: 1)
    expect(result).to eql({ 1=>1 })

    result = subject.call(available_banknotes_info: available_banknotes_info, value_to_cash_out: 55)
    expect(result).to eql({ 50=>1, 5=>1 })
  end

  it 'raises error if its impossible to give cash out' do
    expect { subject.call(available_banknotes_info: available_banknotes_info, value_to_cash_out: 58) }.to raise_error

    expect { subject.call(available_banknotes_info: {}, value_to_cash_out: 1) }.to raise_error
  end

end
