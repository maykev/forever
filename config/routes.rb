Rails.application.routes.draw do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    root 'main#index'

    resources :blog, only: [:index]
    resources :contact_us, only: [:index, :create]
    resources :emma, only: [:index]
    resources :gallery, only: [:index]
    resources :invitation, only: [:index, :show, :update]
    get '/invitation/thanks/:id', to: 'invitation#thanks'
    resources :location, only: [:index]
    resources :our_story, only: [:index]
    resources :registry, only: [:index]
    resources :rsvp, only: [:index]
end
