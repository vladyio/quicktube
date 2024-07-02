require 'sidekiq/web'

Rails.application.routes.draw do
  unless Rails.env.production?
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#index'

  get 'home/index'
  get 'dl/*filename', to: 'download#show', as: :download_file, format: false
  get 'download/index'


  get 'up' => 'rails/health#show', as: :rails_health_check
end
