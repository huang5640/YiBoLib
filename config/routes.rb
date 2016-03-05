Rails.application.routes.draw do
  resources :locations
  get 'sessions/new'

  get 'checkings/new' => 'checkings#new', as: 'new_checking'

  resources :users
  resources :books
  resources :checkings, except: [:checking, :new]

  get "books/index" => 'books#index'
  get "books/new" => 'books#new', as: 'new'
  get "books/:id/edit" => 'books#edit'
  get "books/:id/" => "books#show"
  get "books/:id/checkingIn" => "books#checkingIn", as: 'checking_in'
  get "books/:id/checkOut/:YiBoID" => "books#checkingOut", as: 'checking_out'
  get "checking" => "books#checking", as: 'checking_book'
  get "users/:id/history" => "users#history", as: 'user_history'
  get "books/:id/history" => "books#history", as: 'book_history'
  get "/fetch_books" => 'books#fetch_books', as: 'fetch_books'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  
  post 'checkings/choose_checking' => 'checkings#checking', as: 'choose_checking'

  root "sessions#new"
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
