class Address
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  field :address, type: String
  field :coordinates, type: Array
  field :place_id, type: String
  field :city, type: String
  field :state, type: String
  field :country, type: String
  field :zipcode, type: String

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.city    = geo.city
      obj.state = geo.state
      obj.country = geo.country_code
      obj.zipcode = geo.postal_code
      obj.place_id = geo.place_id
      obj.coordinates = geo.coordinates
    end
  end

  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }
  embedded_in :addressable, polymorphic: true

  def self.location_search(location)
    options = {
      types: 'geocode',
      language: 'en',
      input: location,
      key: ENV['GOOGLE_MAPS_API_KEY']
    }
    response = HTTParty.get(GOOGLE_MAPS_API, query: options, timeout: 20)
    results = JSON.parse(response.body)
    return [] if results['status'] != 'OK'
    results['predictions'].map { |loc| {name: loc['description']} }
  end
end
