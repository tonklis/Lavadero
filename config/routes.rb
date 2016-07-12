Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "display#index"  
      
  match 'bookings/in_the_future_by_courier', :to => 'bookings#in_the_future_by_courier', :via => [:get, :post, :options]
  match 'bookings/by_booking_and_item', :to => 'bookings#by_booking_and_item', :via => [:get, :post, :options]

end
