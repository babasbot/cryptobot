$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv/load'
require 'i18n'
require 'net/http'
require 'json'
require 'ostruct'
require 'crypto_bot/adapter'
require 'crypto_bot/command'
require 'crypto_bot/command/btc'
require 'crypto_bot/command/eth'
require 'crypto_bot/command/xrp'
require 'crypto_bot/command/ltc'
require 'crypto_bot/utils/string'
require 'telegram/bot'

String.include CryptoBot::Utils::String

I18n.load_path = Dir['config/locales/*.yml']

authorization_token = ENV['AUTHORIZATION_TOKEN']

unless authorization_token
  missing_authorization_token = I18n.t('errors.missing_authorization_token')
  raise ArgumentError, missing_authorization_token
end

Telegram::Bot::Client.run(authorization_token) do |bot|
  bot.listen do |message|
    case message.text
    when '/btc'
      CryptoBot::Command::BTC.execute(bot, message)
    when '/eth'
      CryptoBot::Command::ETH.execute(bot, message)
    when '/xrp'
      CryptoBot::Command::XRP.execute(bot, message)
    when '/ltc'
      CryptoBot::Command::LTC.execute(bot, message)
    end
  end
end
