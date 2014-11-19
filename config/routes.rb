Rails.application.routes.draw do


  root    "home#index"

######### authorization

# this route is weird because sessions#new doesn't actually do anything, I just want omniauth to do some magic, what do I do?
  get    "/auth/:provider/callback", to: "sessions#create",  as: :sessions
  delete  "/users/signout",           to: "sessions#destroy", as: :signout


  # get     "/users/:current_user/feed",          to: "feed#show",        as: :feed

  # post  "/auth/:provider/callback",    to: "users#create", as:   :user_create

  get     "/users/:id/feed",          to: "feed#show",        as: :feed


  get   "/twitter", to: "feed#index"

  get "/home/search",                 to: "home#search",      as: :search_results
  post "/home/search",                to: "home#search",      as: :search
  post "/users/subscribe/:id",  to: "users#subscribe",  as: :subscribe
  get "/home/subscribed", to: "home#subscribed", as: :subscribed_path

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
