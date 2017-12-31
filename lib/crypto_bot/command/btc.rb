module CryptoBot
  class Command
    class BTC < CryptoBot::Command
      def adapter
        CryptoBot::Adapter::Bitso::BTC.new
      end
    end
  end
end
