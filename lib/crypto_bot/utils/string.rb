module CryptoBot
  module Utils
    module String
      def money
        reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
      end
    end
  end
end
