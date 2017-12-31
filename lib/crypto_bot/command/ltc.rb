module CryptoBot
  class Command
    class LTC < CryptoBot::Command
      def adapter
        CryptoBot::Adapter::Bitso::LTC.new
      end
    end
  end
end
