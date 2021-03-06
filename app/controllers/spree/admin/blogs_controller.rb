# frozen_string_literal: true

module Spree
  module Admin
    class BlogsController < ResourceController
      def show
        redirect_to admin_blogs_path
      end

      private

      def find_resource
        Spree::Blog.friendly.find(params[:id])
      end

      def collection
        params[:search] ||= {}
        params[:search][:meta_sort] ||= 'name.asc'
        @search = Spree::Blog.search(params[:q])
        @collection = @search.result.page(params[:page]).per(Spree::Config[:admin_orders_per_page])
      end
    end
  end
end
