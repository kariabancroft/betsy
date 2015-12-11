Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'welcome#index'

  resources :carts

  post "/products/:id/add_review" => 'products#create_review', as: :create_review

  post "/carts/:product_id/remove" => 'carts#remove_quantity', as: :remove_quantity
  post "/carts/:product_id/add" => 'carts#add_quantity', as: :add_quantity

  resources :sessions, :only => [:new, :create]
  delete "/logout", to: 'sessions#destroy', as: :logout

  get 'orders/checkout' => 'orders#checkout', as: :checkout
  post 'orders/checkout' => 'orders#create'
  get 'orders/:id/confirm' => 'orders#confirm', as: :order_confirm

  resources :categories

  post "products/:id/review" => "reviews#create", as: :new_review
  resources :products, :only => [:show]

  get "merchants/:id/home" => "merchants#home", as: :merchant_home

  resources :merchants do
    resources :products
    resources :orders, :only => [:index, :show, :edit, :update]
  end





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
