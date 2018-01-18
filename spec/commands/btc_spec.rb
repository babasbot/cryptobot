RSpec.describe CryptoBot::Command::BTC do
  describe '#execute' do
    let(:bot)     { double(api: double) }
    let(:message) { double(chat: double(id: 1)) }

    let(:text) do
      <<~MARKDOWN
        *$237,000.00 BTC/MXN*

        High: `$242,450.00`
        Low:  `$171,000.00`
        Ask:  `$238,927.76`
        Bid:  `$237,000.00`

        24h Volume: `977.33897533`
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

      VCR.use_cassette('bitso_btc_mxn') do
        command = described_class.new(bot, message)
        command.execute
      end
    end
  end
end
