class CheckfrontDatum < ApplicationRecord

  BOOKING_URL = "/api/3.0/booking/"
  ITEM_URL = "/api/3.0/item/"
  CATEGORY_URL = "/api/3.0/category/"
  BOOKING_UPDATE_URL = "/api/3.0/booking/[id]/update"

  validates_inclusion_of :singleton_guard, :in => [0]  

  def self.instance
    begin
      find(1)
    rescue ActiveRecord::RecordNotFound
      row = CheckfrontDatum.new
      row.singleton_guard = 0
      row.save!
      row
    end
  end

  def self.get_and_save_latest_bookings

    bookings_hash = self.get_bookings_in_the_future
    booking_ids = []
    bookings_hash.each do |key, bookings|
      booking_ids.push(bookings["booking_id"])
    end

    bookings = []
    booking_ids.each do |booking_id|
      bookings.push(self.get_booking_by_id booking_id)
    end

    self.instance.update_attribute(:bookings, bookings)

  end 

  def self.update_booking booking
    
    bookings = eval(CheckfrontDatum.instance.bookings) 

    bookings.each do |source_booking|
      if source_booking["id"] == booking["id"]
        bookings = bookings - [source_booking]
        bookings << booking
      end
    end
    
    self.instance.update_attribute(:bookings, bookings)   

  end

  ## Methods connecting with Checkfront

  #BOOKINGS
  
  def self.get_bookings_in_the_future

    url = ENV['HOST'] + BOOKING_URL 
    end_date = {end_date: ">#{Time.zone.now.beginning_of_day.to_i}"}
    @bookings = (Connection.post_json_response url, end_date)["booking/index"]
    if not @bookings
      return []
    else
      return @bookings
    end
  end

  def self.get_booking_by_id id
    url = ENV['HOST'] + BOOKING_URL + id.to_s
    @booking = (Connection.get_json_response url)["booking"]
  end

  def self.booking_change_param booking_id, name, value

    url = ENV['HOST'] + BOOKING_UPDATE_URL
    url.sub!("[id]", booking_id.to_s)
    update_param = {name => value}

    Connection.post_json_response url, update_param
    return self.get_booking_by_id booking_id

  end

  def self.booking_change_status booking_id, name, value

  url = ENV['HOST'] + BOOKING_UPDATE_URL
    url.sub!("[id]", booking_id.to_s)
    status = {status_id: new_status_id}

    Connection.post_json_response url, status
    #TODO: change locally
    return {bookings: [(Booking.by_id booking_id)]}

  end

  #ITEMS
  
  def self.get_item_by_id id
    url = ENV['HOST'] + ITEM_URL + id.to_s
    @item = (Connection.get_json_response url)["item"]
  end

end
