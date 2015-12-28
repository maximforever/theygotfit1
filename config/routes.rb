Rails.application.routes.draw do


  root 'records#search'

  get '/home' => 'pages#index', as: :profile
  get '/about' => 'pages#about'
  get '/faq' => 'pages#faq', as: :faq
  get '/comments' => 'pages#comments', as: :comments
  post '/feedbacks' => 'pages#new_comment'
  get '/updates' => 'pages#updates'

  get '/users' => 'users#index'
  get '/user/:username' => 'users#show', as: :user
  get '/users/new' => 'users#new', as: :new_user
  post '/users' => 'users#create'
  get '/user/:username/edit/' => 'users#edit', as: :preferences
  get '/user/:username/about_me/' => 'users#about_me', as: :edit_about
  patch '/user/:username' => 'users#update'
  delete '/user/:username' => 'users#destroy', as: :delete_user


  get '/login' => 'sessions#new', as: :login 
  post '/login' => 'sessions#create', as: :login_fully
  get '/logout' => 'sessions#destroy', as: :logout

  get '/special' => 'pages#special'

  get '/records/new' => 'records#new', as: :new_record
  post '/records' => 'records#create'
  get '/record/:id' => 'records#show', as: :record
  get '/records/all' => 'records#index'
  delete '/record/delete/:id' => 'records#delete', as: :delete_record

  get '/search' => 'records#search', as: :search
  get '/find' => 'records#find'
  get '/find_id' => 'records#find_id'


  resources :password_resets


  resources :users do
    member do
      get :confirm_email
    end
  end



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
