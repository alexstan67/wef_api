class Api::V1::AirportsController < ApplicationController
  skip_before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :display_no_record_error

  def index
    continent = params[:continent]
    country   = params[:country]
    if !continent.nil?
      if [ "EU", "NA", "AF", "AN", "AS", "OC", "SA"].include?(continent)
        render json: Airport.find_by(continent: continent)
      else
        display_no_record_error("Continent not existing, please enter valid code.")
      end
    elsif !country.nil?
      if Country.distinct.pluck(:code).include?(country)
        render json: Airport.where(country: country)
      else
        display_no_record_error("Country code not existing, please enter valid code.")
      end
    else
        render json: Airport.all
    end
  end

  def show
    airport = Airport.find_by(id: params[:id])
    render json: airport
  end

  def airports_within_range
    airport_id        = params[:id].to_i
    range             = params[:range].to_i
    margin            = params[:margin].to_i
    unit              = params[:unit]

    # Loading default config
    app_config = YAML.load_file("#{Rails.root}/config/app.yml")
    margin_default = app_config["airports_within_range_margin_nm"].to_i

    # Testing values
    unit    = params[:unit].nil? ? "nm" : "km"
    margin  = params[:margin].nil? ? margin_default : margin

    # We apply unit conversions
    if unit = "km"
      range   /= 1.852
      margin  /= 1.852
    end

    # Loading origin airport
    airport = Airport.find(airport_id)

    # SQL query implementing Haversine formula to calculate distance in nm based on GPS coordinates
    limit = 10 #TODO: Remove after testing
    sql = "SELECT \
            (((acos(sin(( ? * pi() / 180)) * sin((latitude * pi() / 180)) + cos(( ? * pi() / 180)) \
            * cos((latitude * pi() / 180)) * cos((( ? - longitude) * pi() / 180)))) * 180 / pi()) \
            * 60 ) AS distance, airports.* \
          FROM \
            airports \
          WHERE \
            (((acos(sin(( ? * pi() / 180)) * sin((latitude * pi() / 180)) + cos(( ? * pi() / 180)) \
            * cos((latitude * pi() / 180)) * cos((( ? - longitude) * pi() / 180)))) * 180 / pi()) \
            * 60) <= ? \
          AND \
            (((acos(sin(( ? * pi() / 180)) * sin((latitude * pi() / 180)) + cos(( ? * pi() / 180)) \
            * cos((latitude * pi() / 180)) * cos((( ? - longitude) * pi() / 180)))) * 180 / pi()) \
            * 60) >= ? \
          ORDER BY \
             airports.country, airports.airport_type \
          LIMIT ?;"
    airports_within_range = Airport.find_by_sql [sql, airport.latitude, airport.latitude, airport.longitude, airport.latitude, airport.latitude, airport.longitude, range + margin, airport.latitude, airport.latitude, airport.longitude, range - margin, limit]

    render json: airports_within_range
  end

  private

  def display_no_record_error(exception)
    #TODO: Maybe to add to ApplicationController directly (https://www.youtube.com/watch?v=RQQ98mbh2Ic)
    render json: { error: exception }, status: :not_found
  end

end
