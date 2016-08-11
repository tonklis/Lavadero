class CheckfrontDataController < ApplicationController
  before_action :authenticate_admin_user!

  #GET /checkfront_data/update_bookings
  def update_bookings
    begin
      CheckfrontDatum.get_and_save_latest_bookings
      render json: {head: "ok"}
    rescue Exception => e
      errors = {:error_updating_bookings => [e.message]}
      render json: ErrorSerializer.serialize(errors), status: 500
    end    
  end
  
end
