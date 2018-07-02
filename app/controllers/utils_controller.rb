class UtilsController < ApplicationController

  def states_list
    states = CS.states(params[:country])
    states = { '': 'Select State' }.merge(states.sort.to_h)
    render json: states.to_json, status: 200
  end

  def cities_list
    cities = {}
    CS.cities(params[:state], params[:country]).each {|city| cities[city] = city }
    cities = { '' => 'Select City' }.merge(cities)
    render json: cities.to_json, status: 200
  end

  def location_search
    locations = Address.location_search(params[:term])
    render json: locations.to_json, status: 200
  end
end
