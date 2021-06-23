require_relative "../spec_helper"

RSpec.describe Credit::Card do
  let(:card_number) { "4003600000000014" }

  it "Returns VISA for visa card number" do
    expect(described_class.new.validate(card_number)).to eq('VISA')
  end
end
