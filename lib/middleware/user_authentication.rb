# Public: A middleware for checking the user from api_key request.
# Apart from checking the availability of data users,
# this middleware also has the responsibility to validate
# the IP address of the request that is sent.
#
# Examples:
#
#   config.middleware.use Middleware::UserAuthentication
#
# Provided data:
#
#   request.env[:current_user]
#   #> "#<User:0x00007fc2e4beda08>"
#
module Middleware
  class UserAuthentication
    PREFIX_API_V1_PATH = '/api/v1'.freeze
    EXCLUDED_PATHS = %w[/api/v1/users].freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)
      return @app.call(env) if not_request_from_api_v1?(request) || excluded_path?(request)

      current_user = find_current_user(request)
      return unauthorized_error_response(request) if current_user.blank?

      env[:current_user] = current_user

      @app.call(request.env)
    end

    private

    def not_request_from_api_v1?(request)
      request_prefix_path = request.path[0..6]
      request_prefix_path != PREFIX_API_V1_PATH
    end

    def excluded_path?(request)
      EXCLUDED_PATHS.include?(request.path)
    end

    def find_current_user(request)
      api_key = request.headers['Authorization']
      cached_user = Rails.cache.read("user_api_key:#{api_key}")

      if cached_user
        cached_user
      else
        user = User.find_by!(api_key: api_key)

        # Validate api_key to be case sensitive
        return nil if api_key != user&.key

        Rails.cache.write("user_api_key:#{api_key}", user, expires_in: ENV.fetch('API_KEY_EXPIRE_CACHE_IN_DAYS', 7).to_i.days)
        user
      end
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def unauthorized_error_response(request)
      proc do |_env|
        [
          401,
          { 'Content-Type' => 'application/json' },
          [unauthorized_error_json]
        ]
      end.call(request.env)
    end

    def unauthorized_error_json
      {
        errors: [
          {
            status: 401,
            title: 'Unauthorized',
            detail: 'You are not authorized to make the request'
          }
        ]
      }.to_json
    end
  end
end
