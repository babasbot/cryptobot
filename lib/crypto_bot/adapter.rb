module CryptoBot
  module Adapter
    class Bitso
      def initialize
        @uri = URI('https://api.bitso.com/v3/ticker')
      end

      def text
        currency = self.class.name.split('::').last

        <<~TEXT
          *$#{response.last.money} #{currency}/MXN*

          High: `$#{response.high.money}`
          Low:  `$#{response.low.money}`
          Ask:  `$#{response.ask.money}`
          Bid:  `$#{response.bid.money}`

          24h Volume: `#{response.volume}`
        TEXT
      end

      private

        def response
          @response ||= begin
            response = Net::HTTP.get_response(@uri)
            return unless response.is_a?(Net::HTTPSuccess)

            payload = JSON.parse(response.body)&.[]('payload')
            OpenStruct.new(payload)
          end
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

      class LTC < CryptoBot::Adapter::Bitso
        def initialize
          super
          @uri.query = URI.encode_www_form(book: 'ltc_mxn')
        end
      end
    end
  end
end
