Rails.application.routes.draw do

  # ---------  my notes  -----

  # resources :articles method creates a new resource (collection of similar objects, articles, people, or animals).  Declares a standard REST resource and creates a route for every form of CRUD
  # for example, the route http://localhost:3000/articles/new has been created.  But for it to work you need to have a controller. Create one by using "bin/rails generate controller articles" in terminal
  resources :articles do
    resources :comments # like resources :articles, resources :comments creates a new resource.  It creates routes for all comments.  Because it is defined within a loop, it makes resources :comments a nested resource of "resources :articles"
  end
  

  get 'welcome/index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "bin/rake routes".


  # You can have the root of your site routed with "root"
  root 'welcome#index' # connects the root of your site to a specific controller and action. It tells rails to map request to the root of the application to the welcome controller's index action and 'get welcome/index' tells rails to map requests to http://localhost:3000/welcome/index
  # to rephrase, if there is a get request for welcome, this says to map it to the root action in the WelcomeController

  #-------- ^^^my notes^^^ ------
  
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
