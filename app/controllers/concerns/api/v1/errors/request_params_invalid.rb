module Api
  module V1
    module Errors
      class RequestParamsInvalid < Api::V1::Errors::Application
        DEFAULT_DETAIL_MESSAGE = 'Request params was invalid'.freeze

        def initialize(detail)
          @status = 422
          @title = 'RequestParamsInvalid'
          @detail = detail || DEFAULT_DETAIL_MESSAGE
          super(@detail)
        end
      end
    end
  end
end
