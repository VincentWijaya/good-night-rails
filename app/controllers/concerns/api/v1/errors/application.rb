module Api
  module V1
    module Errors
      class Application < StandardError
        attr_reader :title, :status, :detail
      end
    end
  end
end
