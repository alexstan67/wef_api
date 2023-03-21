
class Api::V1::AirportsController < ApplicationController
  skip_before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    continent = params[:continent]
    country   = params[:country]
    if !continent.nil?
      if [ "EU", "NA", "AF", "AN", "AS", "OC", "SA"].include?(continent)
        render json: Airport.find_by(continent: continent)
      else
        display_error("Continent not existing, please enter valid code.")
      end
    elsif !country.nil?
      if Country.distinct.pluck(:code).include?(country)
        render json: Airport.where(country: country)
      else
        display_error("Country code not existing, please enter valid code.")
      end
    else
        render json: Airport.all
    end
  end
  def show
    airport = Airport.find_by(id: params[:id])
    render json: airport
  end

  private

  def display_error(exception)
    render json: { error: exception }, status: :not_found
  end

end
