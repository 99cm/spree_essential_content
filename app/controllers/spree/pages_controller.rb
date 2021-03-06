# frozen_string_literal: true

module Spree
  class PagesController < StoreController

    helper 'spree/blogs/posts'
    helper 'spree/products'

    def show
      @page = current_page
      raise ActionController::RoutingError, "No route matches [GET] #{request.path}" if @page.nil?
      if @page.root?
        @posts = Spree::Post.live.limit(5)
        render template: 'spree/pages/home'
      end
    end

    private

    def accurate_title
      @page.meta_title
    end
  end
end
