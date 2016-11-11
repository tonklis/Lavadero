class BookingsController < ApiController

  before_action :authenticate_user!

  #POST /bookings/in_the_future_by_courier
  def in_the_future_by_courier
    begin
      bookings = Booking.in_the_future_by_courier current_user.name, current_user.roles
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

  #POST /bookings/change_status
  def change_status
    begin
      booking = Booking.change_status params[:booking_id].to_i, params[:old_status_id], params[:new_status_id]
      render json: BookingSerializer.serialize(booking)
    rescue Exception => e
      errors = {:error_retrieving_bookings => [e.message]}
      render json: ErrorSerializer.serialize(errors), status: 500
    end
  end

  #POST /bookings/change_param
  def change_param 
    begin
      booking = Booking.change_param params[:booking_id].to_i, params[:name], params[:value]
      render json: BookingSerializer.serialize(booking)
    rescue Exception => e
      errors = {:error_retrieving_bookings => [e.message]}
      render json: ErrorSerializer.serialize(errors), status: 500
    end
  end

end
