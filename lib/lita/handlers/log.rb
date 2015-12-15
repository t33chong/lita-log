module Lita
  module Handlers
    class Log < Handler
      LEVELS = ['unknown', 'fatal', 'error', 'warn', 'info', 'debug']

      route(
        /^log\s+(?<level>\w+)\s+(?<message>.*)/i,
        :log_message,
        command: true,
        restrict_to: :log_admins,
        help: { t('help.log_key') => t('help.log_value') }
      )

      def log_message(response)
        level = response.match_data[:level].downcase
        message = response.match_data[:message].strip

        return response.reply(t('log.invalid', level: level)) unless LEVELS.include?(level)

        log.send(level.to_sym, message)
        response.reply(t('log.success', level: level.upcase, message: message))
      end

      Lita.register_handler(self)
    end
  end
end
