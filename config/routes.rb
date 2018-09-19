Rails.application.routes.draw do
  root "watchers#new"
  resources :watchers

  get "confirmation/:id/pending" => "confirmations#pending", as: "pending_confirmation"
  post "confirmation/:id/pending" => "confirmations#resend"
  get "confirmation/:token" => "confirmations#confirm", as: "confirmation"

  get "subscriptions/:token" => "subscriptions#edit", as: "edit_subscription"
  get "unsubscribe/:token" => "subscriptions#remove", as: "unsubscribe"
  delete "unsubscribe/:token" => "subscriptions#destroy"

  get ".well-known/stellar.toml" => "federation#toml",
      defaults: {format: "toml"},
      constraints: {format: /toml/}

  mount Sidekiq::Web => "/sidekiq"
end
