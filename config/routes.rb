Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql#execute"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace 'api' do
    namespace 'v1' do
      resources :users, only: [] do
        collection do
          post 'sign_up'
          post 'login'
          post 'send_reset_password_email'
          post 'reset_password'
        end
      end
    end
  end
end
