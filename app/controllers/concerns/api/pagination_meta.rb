module Api
  module PaginationMeta
    extend ActiveSupport::Concern

    included do
      def pagination_options(resource, use_controllerd_page_size: false)
        {
          meta: {
            current_page: resource.current_page,
            page_size: page_size
          }
        }
      end
    end
  end
end
