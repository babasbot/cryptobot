RSpec.describe CryptoBot::Command::XRP do
  describe '#execute' do
    let(:bot)     { double(api: double) }
    let(:message) { double(chat: double(id: 1)) }

    let(:text) do
      <<~MARKDOWN
        *$27.40 XRP/MXN*

        High: `$29.34`
        Low:  `$27.00`
        Ask:  `$27.40`
        Bid:  `$27.25`

        24h Volume: `10558960.38652415`
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

      VCR.use_cassette('bitso_xrp_mxn') do
        command = described_class.new(bot, message)
        command.execute
      end
    end
  end
end
