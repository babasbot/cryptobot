RSpec.describe CryptoBot::Command::ETH do
  describe '#execute' do
    let(:bot)     { double(api: double) }
    let(:message) { double(chat: double(id: 1)) }

    let(:text) do
      <<~MARKDOWN
        *$19,990.00 ETH/MXN*

        High: `$20,499.96`
        Low:  `$19,400.08`
        Ask:  `$20,329.81`
        Bid:  `$19,990.00`

        24h Volume: `5785.20587272`
      MARKDOWN
    end

    let(:message_options) do
      {
        chat_id:    message.chat.id,
        text:       text,
        parse_mode: 'Markdown'
      }
    end

    it 'sends to telegram the response message' do
      expect(bot.api).to receive(:send_message).with(message_options)

      VCR.use_cassette('bitso_eth_mxn') do
        command = described_class.new(bot, message)
        command.execute
      end
    end
  end
end
