Rails.application.routes.draw do
  root "watchers#new"
  resources :watchers

  get "confirmation/:id/pending" => "confirmations#pending", as: "pending_confirmation"
  post "confirmation/:id/pending" => "confirmations#resend"
  get "confirmation/:token" => "confirmations#confirm", as: "confirmation"

  get "unsubscribe/:token" => "subscriptions#remove", as: "unsubscribe"
  delete "unsubscribe/:token" => "subscriptions#destroy"

  mount Sidekiq::Web => "/sidekiq"
end