class StationAvailabilitiesController < ApplicationController
  def index
    @station_availability = StationAvailability.new(station_id: params[:station_id])

    @station_availability.update!
  end

  def show
    @station_availability = StationAvailability.new(station_id: params[:station_id], time: params[:time], day: params[:day])
  end
end
