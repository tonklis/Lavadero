class Booking  
   
  #TODO: ADD ERROR HANDLING
  
  def self.change_param booking_id, name, value

    #change in checkfront
    @booking = CheckfrontDatum.booking_change_param booking_id, name, value
      
    # change locally
    CheckfrontDatum.update_booking @booking
      
    return {bookings: [@booking]}
      
  end

  def self.change_status booking_id, old_status_id, new_status_id

    self.validate_status old_status_id, new_status_id
  
    #change in checkfront      
    @booking = CheckfrontDatum.booking_change_param booking_id, "status_id", new_status_id
      
    # change locally
    CheckfrontDatum.update_booking @booking
      
    return {bookings: [@booking]}
    
  end

  def self.in_the_future_by_courier name

    if not CheckfrontDatum.instance.bookings
      CheckfrontDatum.get_and_save_latest_bookings
    end
      
    bookings = eval(CheckfrontDatum.instance.bookings) 

    items_by_courier = []
    bookings_by_courier = []
    bookings.each do |booking|
      booking["items"].each do |key, item|
        params = item["param"]

        params.each do |courier_name, value|
          if name.downcase.eql? courier_name.downcase
            #if bookings_by_courier.select{ |x| x["id"] == booking["id"] }.empty?
              bookings_by_courier.push(booking.except("meta").except("items"))
            #end
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
    bookings_hash = CheckfrontDatum.get_booking_by_id booking_id   

    bookings = []
    items = []

    if bookings_hash
      bookings_hash["items"].each do |key, item|
        if item["id"].eql? item_id
          bookings.push(bookings_hash.except("meta").except("items"))
          
          q_item = CheckfrontDatum.get_item_by_id item_id
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
