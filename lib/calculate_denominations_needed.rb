class CalculateDenominationsNeeded

  attr_reader :available_banknotes_info
  attr_reader :available_banknotes_info_copy

  def call(available_banknotes_info:, value_to_cash_out:)
    @available_banknotes_info = available_banknotes_info
    spread_out(value_to_cash_out)
  end

  private

  def spread_out(value_to_cash_out, is_data_reset_allowed = true)
    return {} if (value_to_cash_out == 0)

    denominations_not_bigger_then(value_to_cash_out).each do |denomination|
      @available_banknotes_info_copy = available_banknotes_info.clone if is_data_reset_allowed
      result = {}
      
      if is_banknotes_enough_inside_atm(denomination, value_to_cash_out / denomination)
        base = { denomination => value_to_cash_out / denomination }
        @available_banknotes_info_copy[denomination] = @available_banknotes_info_copy[denomination] - (value_to_cash_out / denomination)
        @available_banknotes_info_copy.reject! { |k,v| v == 0 }

        
        remainder = spread_out(value_to_cash_out % denomination, false)
        
        result = base.merge(remainder)
      elsif @available_banknotes_info_copy[denomination]
        available_denominations_count = @available_banknotes_info_copy[denomination]

        base = { denomination => available_denominations_count }
        @available_banknotes_info_copy[denomination] = @available_banknotes_info_copy[denomination] - available_denominations_count
        @available_banknotes_info_copy.reject! { |k,v| v == 0 }

        rest = value_to_cash_out - available_denominations_count * denomination
        
        remainder = spread_out(rest, false)
        
        result = base.merge(remainder)
      end

      if is_result_valid?(result, value_to_cash_out)
        return result
      else
      end
    end


    return {}
  end

  def all_denominations
    [50, 25, 10, 5, 2, 1]
  end

  def denominations_not_bigger_then(value)
    all_denominations.select { |denomination| denomination <= value }
  end

  def is_banknotes_enough_inside_atm(denomination, count)
    return false unless @available_banknotes_info_copy[denomination]
    count <= @available_banknotes_info_copy[denomination]
  end

  def is_result_valid?(result, value_to_cash_out)
    sum = 0
    result.each do |denomination, banknotes_count|
      sum += denomination.to_i * banknotes_count
    end
    sum == value_to_cash_out
  end

end
