module Api
  class ApplicationController < ActionController::API
    include Api::V1::ExceptionsHandler

    def current_user
      request.env[:current_user]
    end
  end
end
