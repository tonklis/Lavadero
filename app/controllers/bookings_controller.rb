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

  #POST /bookings/by_booking_and_item
  def by_booking_and_item
    begin
      bookings = Booking.by_booking_and_item params[:booking_id].to_i, params[:item_id].to_i
      render json: BookingSerializer.serialize(bookings)
    rescue Exception => e
      errors = {:error_retrieving_bookings => [e.message]}
      render json: ErrorSerializer.serialize(errors), status: 500
    end
  end

end
