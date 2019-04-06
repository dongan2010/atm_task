Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :cash_out, only: :create, controller: "cash_out"
      resource :replenish, only: :create
    end
  end
end
