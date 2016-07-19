class Booking  

  BOOKING_URL = "/api/3.0/booking/"
  ITEM_URL = "/api/3.0/item/"
  CATEGORY_URL = "/api/3.0/category/"
  BOOKING_UPDATE_URL = "/api/3.0/booking/[id]/update"

  def self.item_by_id id
    url = ENV['HOST'] + ITEM_URL + id.to_s
    @item = (Connection.get_json_response url)["item"]
  end

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
    if not @bookings
      return []
    else
      return @bookings
    end
  end

  def self.change_status booking_id, old_status_id, new_status_id

    Booking.validate_status old_status_id, new_status_id
    
    url = ENV['HOST'] + BOOKING_UPDATE_URL
    url.sub!("[id]", booking_id.to_s)
    status = {status_id: new_status_id}

    Connection.post_json_response url, status
    return {bookings: [(Booking.by_id booking_id)]}
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

  def self.by_booking_and_item booking_id, item_id
    bookings_hash = Booking.by_id booking_id   

    bookings = []
    items = []

    if bookings_hash
      bookings_hash["items"].each do |key, item|
        if item["id"].eql? item_id
          bookings.push(bookings_hash.except("meta").except("items"))
          
          q_item = Booking.item_by_id item_id
          item["category"] = q_item["category"]
          items.push(item)
        end
      end
    end
    
    return {bookings: bookings, items: items}
    
  end
 
  def self.validate_status old_status_id, new_status_id

    case old_status_id
    when "HOLD"
      if not new_status_id.eql? "RECOL"
        raise "Transición inválida de #{old_status_id} a #{new_status_id}."
      end
    when "ASIGN"
      if not (new_status_id.eql? "RECOL" or new_status_id.eql? "CAMIN")
        raise "Transición inválida de #{old_status_id} a #{new_status_id}."
      end
    when "CO12", "EFECT", "ENTRE", "PAID", "QUEJA", "FALTA", "REPRO", "PART"
      if not new_status_id.eql? "CAMIN"
        raise "Transición inválida de #{old_status_id} a #{new_status_id}."
      end
    when "RECOL"
      if not (new_status_id.eql? "ENPRO" or new_status_id.eql? "PROBL")
        raise "Transición inválida de #{old_status_id} a #{new_status_id}."
      end      
    when "CAMIN"
      if not (new_status_id.eql? "DONE1" or new_status_id.eql? "PROBL")
        raise "Transición inválida de #{old_status_id} a #{new_status_id}."
      end 
    else
      raise "Estatus inicial no registrado."
    end

    return true

  end

end
