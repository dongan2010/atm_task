class CalculateDenominationsNeeded

  attr_reader :available_banknotes_info
  attr_reader :available_banknotes_info_copy

  def call(available_banknotes_info:, value_to_cash_out:)
    @available_banknotes_info = available_banknotes_info
    spread_out(value_to_cash_out)
  end

  private

  # spread out value_to_cash_out for base and reminder for all dennominations(for 50 denomination  155 = base(50*3) + reminder(5))
  # then do the same thing with reminder
  # untill we find result
  def spread_out(value_to_cash_out, is_first_level_call = true)
    return {} if (value_to_cash_out == 0)

    denominations_not_bigger_then(value_to_cash_out).each do |denomination|
      @available_banknotes_info_copy = available_banknotes_info.clone if is_first_level_call
      result = {}
      
      if is_banknotes_enough_inside_atm(denomination, value_to_cash_out / denomination)
        banknotes_count = value_to_cash_out / denomination

        # caalculate base
        base = { denomination => banknotes_count }
        update_available_banknotes_copy_info(denomination, -banknotes_count)

        # caalculate reminder
        remainder = spread_out(value_to_cash_out % denomination, false)

        # merge them
        result = base.merge(remainder)
      elsif @available_banknotes_info_copy[denomination]
        banknotes_count = @available_banknotes_info_copy[denomination]

        # caalculate base
        base = { denomination => banknotes_count }
        update_available_banknotes_copy_info(denomination, -banknotes_count)

        # caalculate reminder
        rest = value_to_cash_out - banknotes_count * denomination
        remainder = spread_out(rest, false)

        # merge them
        result = base.merge(remainder)
      end

      return result if is_result_valid?(result, value_to_cash_out)
    end

    raise AtmTaskErrors::ImpossibleToCashOutError if is_first_level_call
  end

  def update_available_banknotes_copy_info(denomination, banknotes_count)
    @available_banknotes_info_copy[denomination] = @available_banknotes_info_copy[denomination] + banknotes_count
    @available_banknotes_info_copy.reject! { |k,v| v == 0 }
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
