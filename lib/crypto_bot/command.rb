module CryptoBot
  class Command
    def self.execute(*args)
      new(*args).execute
    end

    def initialize(bot, message)
      @bot     = bot
      @message = message
    end

    def execute
      options = { chat_id: chat_id, text: text, parse_mode: 'Markdown' }
      @bot.api.send_message(options)
    end

    protected

      def chat_id
        @message.chat.id
      end

      def text
        adapter.text
      end
  end
end
