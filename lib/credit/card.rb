module Credit
  class Card
    # === Validates whether credit card number has correct format (formats it if not) and checks
    # whether the number is correct
    # @param [card_nr] String
    # @return [String]
    def validate(_card_number)
      card_nr = clean(_card_number)
      check_entry_data_format card_nr.to_s
      return card_type card_nr if luhn_algorithm card_nr

      Credit::Names::INVALID
    end

    # === Verifies the correctness of credit card number by using Luhn Algorithm
    # @param [card_nr] Integer
    # @return [Boolean]
    def luhn_algorithm(card_nr)
      sum_a_arr = []
      sum_b_arr = []
      counter = -1
      card_nr.to_s.reverse.chars.map(&:to_i).each do |digit|
        counter = counter.next
        if counter.zero?
          sum_b_arr << digit
          next
        end

        if counter.even?
          sum_b_arr << digit
        else
          sum_a_arr << digit * 2
        end
      end

      digits_sum = (unzip_digits(sum_a_arr) + unzip_digits(sum_b_arr)).reduce { |a, b| a + b }
      return true if (digits_sum % 10).zero?

      false
    end

    # === Returns the type of credit card for American Express, MasterCard and Visa
    # @param [card_nr] String
    # @return [String]
    def card_type(card_nr)
      case card_nr.to_s[0].to_i # first digit
      when 3
        Credit::Names::AMEX
      when 4
        Credit::Names::VISA
      when 5
        Credit::Names::MASTERCARD
      else
        Credit::Names::INVALID
      end
    end

    private

    # === Cleans card number from spaces and dashes
    # @param [card_nr] String
    # @return [Integer]
    def clean(card_nr)
      raise Credit::Error, "incorrect data!" unless card_nr.to_s.match(/^[\d\s\-]+$/)

      card_nr.to_s.split("").delete_if { |v| [" ", "-"].include?(v) }.join.to_i
    end

    # === Checks the format of card number, raises error when invalid
    # @param [card_nr] String
    # @return [Boolean]
    def check_entry_data_format(card_nr)
      nr = card_nr.to_s
      first = %w[4 34 37 51 52 53 54 55]
      raise Credit::Error, "Card number #{card_nr} is too short!" if nr.size < 13
      raise Credit::Error, "Card number #{card_nr} is too long!" if nr.size > 16

      unless first.include?(nr[0..1]) || first.include?(nr[0])
        raise Credit::Error,
              "Incorrect starting digits #{card_nr} !"
      end

      true
    end

    # === Method separates digits and sums them
    # @param [digits_arr] Array
    # @return [Array]
    def unzip_digits(digits_arr)
      digits_arr.map! do |digit|
        digit.to_s.split("").map(&:to_i).reduce { |a, b| a + b }
      end
    end
  end
end
