Rails.application.routes.draw do
  get 'reviews' => 'reviews#index'
  post 'reviews' => 'reviews#create'

  get 'tags' => 'keywords#index'
  get 'categories' => 'categories#index'

  get 'tickets/my_list' => 'tickets#my_list'
  post 'tickets/:id/stock' => 'tickets#stock'
  patch 'tickets/:id/buy' => 'tickets#buy'
  delete 'tickets/:id/stock' => 'tickets#unstock'
  resources :tickets

  patch 'users/:id' => 'users#update'
  post 'users/:id/select_tags/' => 'users#select_tags'
  delete 'users/:id' => 'users#destroy'
  devise_for :users, :skip => [:sessions], :controllers => { registrations: 'registrations' }
  as :user do
    post 'login' => 'sessions#create', :as => :user_session
    delete 'logout' => 'authentication_tokens#destroy', :as => :destroy_user_session
  end
  get 'hello' => 'hello#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
