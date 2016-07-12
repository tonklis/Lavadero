class Booking 

  BOOKING_URL = "/api/3.0/booking/"

  def self.all
    url = ENV['HOST'] + BOOKING_URL
    @bookings = Connection.get_json_response url
  end

  def self.by_id id
    url = ENV['HOST'] + BOOKING_URL + id.to_s
    @booking = (Connection.get_json_response url)["booking"]
  end

  def self.in_the_future
    url = ENV['HOST'] + BOOKING_URL 
    end_date = {end_date: ">#{Time.zone.now.beginning_of_day.to_i}"}
    #end_date = {end_date: "<#{Time.zone.now.to_i}"}
    @bookings = (Connection.post_json_response url, end_date)["booking/index"]
  end

  def self.in_the_future_by_courier name
    bookings_hash = Booking.in_the_future
    booking_ids = []
    bookings_hash.each do |key, bookings|
      booking_ids.push(bookings["booking_id"])
    end

    bookings = []
    booking_ids.each do |booking_id|
      bookings.push(Booking.by_id booking_id)
    end

    items_by_courier = []
    bookings_by_courier = []
    bookings.each do |booking|
      booking["items"].each do |key, item|
        params = item["param"]

        params.each do |courier_name, value|
          if name.downcase.eql? courier_name.downcase
            bookings_by_courier.push(booking.except("meta").except("items"))
            item["booking_uid"] = booking["id"]
            item["booking_id"] = booking["booking_id"]
            items_by_courier.push(item)
          end
        end

      end
    end
    
    return {bookings: bookings_by_courier, items: items_by_courier}

  end

end
