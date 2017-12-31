module CryptoBot
  class Command
    class XRP < CryptoBot::Command
      def adapter
        CryptoBot::Adapter::Bitso::XRP.new
      end
    end
  end
end
