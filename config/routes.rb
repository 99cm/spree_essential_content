Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :uploads

    resources :pages, constraints: { id: /.*/ } do
      collection do
        post :update_positions
      end

      resources :contents do
        collection do
          post :update_positions
        end
      end

      resources :images, controller: 'page_images' do
        collection do
          post :update_positions
        end
      end
    end

    resources :blogs, constraints: { id: /[a-z0-9\-\_\/]{3,}/ }

    resources :posts, except: [:show] do
      resources :images, except: [:show], controller: 'post_images' do
        collection do
          post :update_positions
        end
      end
      resources :products, execpt: [:show, :edit], controller: 'post_products' do
        collection do
          post :update_positions
        end
      end
      resources :categories, except: [:show], controller: 'post_categories'
    end

    resource :content_settings, only: [:edit, :update]
  end

  constraints(Spree::PossibleBlog) do
    constraints(
      year: /\d{4}/,
      month: /\d{1,2}/,
      day: /\d{1,2}/
    ) do
      get ':blog_id/:year(/:month(/:day))', to: 'posts#index', as: :post_date
      get ':blog_id/:year/:month/:day/:id', to: 'posts#show',  as: :full_post
    end

    get ':blog_id/category/:id', to: 'post_categories#show', as: :post_category, constraints: { id: /.*/ }
    get ':blog_id/search/:query', to: 'posts#search', as: :search_posts, query: /.*/
    get ':blog_id/archive', to: 'posts#archive', as: :archive_posts
    get ':blog_id', to: 'posts#index', as: :blog_posts
  end

  constraints(Spree::PossiblePage) do
    get ':path', to: 'pages#show', as: 'page'
  end
end
