module CryptoBot
  class Command
    class ETH < CryptoBot::Command
      def adapter
        CryptoBot::Adapter::Bitso::ETH.new
      end
    end
  end
end
