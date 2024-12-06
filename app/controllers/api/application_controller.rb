module Api
  class ApplicationController < ActionController::API
    include Api::V1::ExceptionsHandler
  end
end
