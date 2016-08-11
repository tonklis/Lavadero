#!/usr/bin/env ruby
require_relative "../../config/environment"

include Clockwork

# Completar, rechazar y pagar citas
every(5.minutes, 'update_bookings') {

  #codigo
  CheckfrontDatum.get_and_save_latest_bookings  
  
}
