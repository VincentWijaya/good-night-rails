module ExceptionsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_standard_error
  end

  def handle_standard_error(err)
    logger = Rails.logger
    logger.error ERROR_LOG_MESSAGE + err.message
    logger.error ERROR_LOG_BACKTRACE + err.backtrace.join("\n\t")
  end
end
