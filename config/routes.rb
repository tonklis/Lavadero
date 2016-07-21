Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  mount_devise_token_auth_for 'User', at: 'auth', :controllers => {:sessions => "sessions"}, defaults: { format: :json }
  
  devise_scope :user do
    match 'users/sign_in', :to => "sessions#create", :via => [:post, :options]
    get 'logout', :to => "sessions#destroy"
    get 'session', :to => "sessions#get"
  end
      
  match 'bookings/in_the_future_by_courier', :to => 'bookings#in_the_future_by_courier', :via => [:get, :post, :options]
  match 'bookings/by_booking_and_item', :to => 'bookings#by_booking_and_item', :via => [:get, :post, :options]
  match 'bookings/change_status', :to => 'bookings#change_status', :via => [:get, :post, :options]
  match 'bookings/change_param', :to => 'bookings#change_param', :via => [:get, :post, :options]

  root to: "admin/dashboard#index"  

end
