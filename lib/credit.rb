# frozen_string_literal: true

require_relative "credit/version"
require_relative "credit/card"

module Credit
  module Names
    AMEX = "AMEX"
    MASTERCARD = "MASTERCARD"
    VISA = "VISA"
    INVALID = "INVALID"
  end

  class Error < StandardError
    def initialize(msg = "An exception has occured!")
      log_error msg
      super(msg)
    end

    def log_error(msg)
      return if caller.any? { |path| path.match(/.*spec.*/) } # Don't log rspec calls

      log_path = Dir.pwd.split("credit").first + "credit" + File::SEPARATOR + "log"
      File.write(log_path, Time.now.to_s + "\n" + msg + "\n\n", mode: "a")
    end
  end
end
