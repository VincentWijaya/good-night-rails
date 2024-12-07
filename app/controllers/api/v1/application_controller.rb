module Api
  module V1
    class ApplicationController < Api::ApplicationController
      include Api::PaginationMeta

      def current_page
        (params[:page] || 1).to_i
      end

      def page_size
        (params[:per_page] || 20).to_i
      end
    end
  end
end
