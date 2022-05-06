Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :reservations #, only: [:index, :show, :create, :destroy]
    end
  end

end
