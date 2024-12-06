module Api
  module V1
    module ExceptionsHandler
      extend ActiveSupport::Concern

      # rubocop:disable Metrics/BlockLength
      included do
        rescue_from Api::V1::Errors::Application do |error|
          errors = [{ status: error.status, title: error.title, detail: error.detail }]
          render json: { errors: errors }, status: error.status
        end

        rescue_from ActiveModel::ValidationError do |error|
          error_message = error.model.errors.full_messages.to_sentence
          errors = [{ status: 422, title: 'Invalid request', detail: error_message }]
          render json: { errors: errors }, status: :unprocessable_entity
        end

        rescue_from Api::V1::Errors::RequestParamsInvalid do |error|
          errors = [{ status: error.status, title: error.title, detail: error.detail }]
          render json: { errors: errors }, status: error.status
        end

        rescue_from ActiveRecord::RecordInvalid do |exception|
          errors = exception.record.errors.map do |error|
            {
              status: 422,
              title: "#{error.attribute} is invalid",
              detail: error.full_message
            }
          end
          render json: { errors: errors }, status: :unprocessable_entity
        end

        rescue_from ActiveRecord::RecordNotFound do |exception|
          errors = [{ status: 404, title: "#{exception.model} not found", detail: exception.message }]
          render json: { errors: errors }, status: :not_found
        end

        rescue_from JSON::ParserError do |exception|
          Sentry.capture_exception(exception) if ENV['SENTRY_DSN'].present?
          errors = [{ status: 500, title: 'Parser error', detail: exception.message }]
          render json: { errors: errors }, status: :internal_server_error
        end
      end
      # rubocop:enable Metrics/BlockLength
    end
  end
end
