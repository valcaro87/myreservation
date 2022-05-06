Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :bookings #, only: [:index, :show, :create, :destroy]
    end
  end

end
