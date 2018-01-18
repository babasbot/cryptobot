RSpec.describe CryptoBot::Command::LTC do
  describe '#execute' do
    let(:bot)     { double(api: double) }
    let(:message) { double(chat: double(id: 1)) }

    let(:text) do
      <<~MARKDOWN
        *$3,720.00 LTC/MXN*

        High: `$3,899.99`
        Low:  `$3,679.76`
        Ask:  `$3,787.64`
        Bid:  `$3,744.39`

        24h Volume: `4389.48137706`
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

      VCR.use_cassette('bitso_ltc_mxn') do
        command = described_class.new(bot, message)
        command.execute
      end
    end
  end
end
