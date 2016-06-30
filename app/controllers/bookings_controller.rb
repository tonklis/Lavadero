class BookingsController < ApplicationController

  #before_action :authenticate_user!, only: [:in_the_future_by_courier]

  #POST /bookings/in_the_future_by_courier
  def in_the_future_by_courier
    begin
      bookings = Booking.in_the_future_by_courier params[:name]
      render json: BookingSerializer.serialize(bookings)
    rescue Exception => e
      errors = {:error_retrieving_bookings => [e.message]}
      render json: ErrorSerializer.serialize(errors), status: 500
    end
  end

end