Rails.application.routes.draw do
  devise_for :org_people, :controllers => {
    :registrations => "org_people/registrations",
    :sessions => "org_people/sessions",
    :passwords => "org_people/passwords",
    :confirmations => "org_people/confirmations" }
  devise_scope :org_person do
    get 'signup', to: 'org_people/registrations#new'
    get 'signin', to: 'org_people/sessions#new'
    get 'signout', to: 'org_people/sessions#destroy'
  end

  get 'org_companies/people/' => 'org_companies#people', :to => "org_companies_people"

  post 'org_people/edit_position/' => 'org_people#edit_position', :to => "org_people_edit_position"
  post 'org_people/remove_from_company/' => 'org_people#remove_from_company', :to => "org_people_remove_from_company"


  resources :catalogues
  resources :org_people
  resources :org_companies
  resources :org_products
  root "catalogues#index"

  match '/org_register', to:'org_companies#new', via: 'get'

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
