class LocationsController < ApplicationController
	def create
		loc = Location.create(loc_params)
		redirect_to location_path(loc.id)
	end

	private

	def loc_params
		params.require(:location).permit(:latitude, :longitude)
	end
end
