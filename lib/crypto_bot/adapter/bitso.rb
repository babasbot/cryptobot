module CryptoBot
  module Adapter
    class Bitso
      def initialize
        @uri = URI('https://api.bitso.com/v3/ticker')
      end

      def text
        response = Net::HTTP.get_response(@uri)
        response.body if response.is_a?(Net::HTTPSuccess)
      end

      class BTC < CryptoBot::Adapter::Bitso
        def initialize
          super
          @uri.query = URI.encode_www_form(book: 'btc_mxn')
        end
      end

      class XRP < CryptoBot::Adapter::Bitso
        def initialize
          super
          @uri.query = URI.encode_www_form(book: 'xrp_mxn')
        end
      end

      class ETH < CryptoBot::Adapter::Bitso
        def initialize
          super
          @uri.query = URI.encode_www_form(book: 'eth_mxn')
        end
      end
    end
  end
end
