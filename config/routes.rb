Rails.application.routes.draw do
  resources :chat_rooms, only: [:index]

  root 'chat_rooms#index'

  mount ActionCable.server => '/cable'
end
