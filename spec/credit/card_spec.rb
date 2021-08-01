require_relative "../spec_helper"
require_relative "../../lib/credit"

RSpec.describe Credit::Card do
  let(:amex) { "370000000000002" }
  let(:mastercard) { "5555341244441115" }
  let(:visa) { "4988080000000000" }

  describe "#validate" do
    context "when numbers are correct" do
      it "returns AMEX for amex card number" do
        expect(subject.validate(amex)).to eql Credit::Names::AMEX
      end

      it "returns MASTERCARD for mastercard card number" do
        expect(subject.validate(mastercard)).to eql Credit::Names::MASTERCARD
      end

      it "returns VISA for visa card number" do
        expect(subject.validate(visa)).to eql Credit::Names::VISA
      end
    end

    context "when numbers are incorrect" do
      let(:correct_format_incorrect_values) { "5555555555555555" }

      it "returns INVALID for incorrect card number" do
        expect(subject.validate(correct_format_incorrect_values)).to eql Credit::Names::INVALID
      end
    end
  end

  describe "#luhn_algorithm" do
    let(:visa_incorrect) { "4988080000000111" }

    it "returns true for valid number" do
      expect(subject.luhn_algorithm(visa)).to eql(true)
    end

    it "returns false for invalid number" do
      expect(subject.luhn_algorithm(visa_incorrect)).to eql(false)
    end
  end

  describe "#card_type" do
    let(:invalid_nr) { "2988080000000000" }

    it "recognize correct card type" do
      [amex, mastercard, visa, invalid_nr].zip([
                                                 Credit::Names::AMEX, Credit::Names::MASTERCARD, Credit::Names::VISA, Credit::Names::INVALID
                                               ]).each do |numbers_types_arr|
        expect(subject.card_type(numbers_types_arr.first)).to eql(numbers_types_arr.last)
      end
    end
  end

  # It is a moot point whether or not we should test private methods.
  # Because TDD forces to write test first I wrote them anyway and can't see any
  # reasons to delete them, especially because I want to show how I create my tests.

  describe "#clean" do
    let(:visa_dash_space) { "4988-0800 0000-0000" }
    let(:visa_dash) { "4988-0800-0000-0000" }
    let(:visa_space) { "4988 0800 0000 0000" }
    let(:visa_string) { "4988080000000000" }
    let(:visa_integer) { 4988080000000000 }

    it "numbers are correctly formatted" do
      [visa_dash_space, visa_dash, visa_space, visa, visa_string, visa_integer].each do |entry_data|
        expect(subject.send(:clean, entry_data)).to eql(visa.to_i)
      end
    end
  end

  describe "#check_entry_data_format" do
    let(:to_short) { "498808000000" }
    let(:to_long) { "49880800000000000" }

    it "raises error when number is to short" do
      expect { subject.check_entry_data_format to_short }.to raise_error
    end

    it "raises error when number is to long" do
      expect { subject.check_entry_data_format to_long }.to raise_error
    end
  end

  describe "#unzip_digits" do
    it "returns correct sum of unzipped number" do
      expect(subject.send(:unzip_digits, [12, 13])).to eql([3, 4])
    end
  end
end
