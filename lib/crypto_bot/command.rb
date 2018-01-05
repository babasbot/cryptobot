module CryptoBot
  class Command
    class << self
      def execute(*args)
        new(*args).execute
      end

      def parse(message)
        message.match(pattern)&.[]('command')
      end

      private

        def pattern
          /\A(?<command>\/[[:alnum:]\_]+)(@therealcryptobot)?\z/
        end
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
