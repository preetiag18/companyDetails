Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/postal_codes/:postcode/companies', to: 'postal_codes/companies#show', as: 'postal_codes_companies'
end
