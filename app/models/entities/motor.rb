class Motor < Entity

  MOTOR_CATEGORIES = %w(Car Bike Boat Plane Helicopter Other)
  MOTOR_MAKE = %w(Mercedes-Benz BMW AUDI VW Honda)

  field :motor_category, type: String
  field :reg_no, type: String
  field :make, type: String
  field :model, type: String
  field :make_year, type: String
  field :gearbox, type: String
  field :co2_emissions, type: String
  field :trim, type: String
  field :body_type, type: String
  field :fuel_type, type: String
  field :engine_size, type: String
  field :top_speed, type: String
  field :mileage, type: String
  field :acceleration, type: String
  field :fuel_consumption, type: String

  has_and_belongs_to_many :dream_garages
  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following_motors

  scope :with_motor_category, ->(motor_category) { where(motor_category: motor_category) }
  scope :with_reg_no, ->(reg_no) { where(reg_no: reg_no) }
  scope :with_make, ->(make) { where(make: make) }
  scope :with_model, ->(model) { where(model: model) }
  scope :with_make_year, ->(make_year) { where(make_year: make_year) }
  scope :with_gearbox, ->(gearbox) { where(gearbox: gearbox) }
  scope :with_co2_emissions, ->(co2_emissions) { where(co2_emissions: co2_emissions) }
  scope :with_trim, ->(trim) { where(trim: trim) }
  scope :with_body_type, ->(body_type) { where(body_type: body_type) }
  scope :with_fuel_type, ->(fuel_type) { where(fuel_type: fuel_type) }
  scope :with_engine_size, ->(engine_size) { where(engine_size: engine_size) }
  scope :speed_between, -> (mn, mx) { where({ :top_speed.lte => mn, :top_speed.gte => mx }) }
  scope :with_top_speed, ->(top_speed) { where(top_speed: top_speed) }
  scope :with_mileage, ->(mileage) { where(mileage: mileage) }
  scope :with_acceleration, ->(acceleration) { where(acceleration: acceleration) }
  scope :with_fuel_consumption, ->(fuel_consumption) { where(fuel_consumption: fuel_consumption) }



  def self.vehicle_data_lookup(reg_no='AP10HCX')
    reg_no='AP10HCX'
    options = {
      v: 2,
      api_nullitems: 1,
      user_tag: nil,
      auth_apikey: ENV['UKV_API_KEY'],
      key_VRM: reg_no
    }
    response = HTTParty.get(UKV_API, query: options, timeout: 20)
    return default_data if !(response.try(:code) == 200 && response['Response']['StatusCode'].eql?('Success'))
    resp = JSON.parse(response.body)
    match_data(resp)
  end

  private

  def self.options_for(f)
    distinct(f).select(&:present?) 
  end

  def self.match_data(data)
    {
      make: data['Response']['DataItems']['VehicleRegistration']['Make'],
      model: data['Response']['DataItems']['VehicleRegistration']['Model'],
      make_year: data['Response']['DataItems']['VehicleRegistration']['YearOfManufacture'],
      gearbox: data['Response']['DataItems']['VehicleRegistration']['TransmissionType'],
      co2_emissions: data['Response']['DataItems']['VehicleRegistration']['Co2Emissions'],
      trim: data['Response']['DataItems']['ClassificationDetails']['Smmt']['Trim'],
      body_type: data['Response']['DataItems']['SmmtDetails']['BodyStyle'],
      fuel_type: data['Response']['DataItems']['SmmtDetails']['FuelType'],
      engine_size: data['Response']['DataItems']['SmmtDetails']['NominalEngineCapacity'].to_f,
      top_speed: data['Response']['DataItems']['TechnicalDetails']['Performance']['MaxSpeed']['Mph'],
      acceleration: data['Response']['DataItems']['TechnicalDetails']['Performance']['Acceleration']['Mph'],
      fuel_consumption: data['Response']['DataItems']['TechnicalDetails']['Consumption']['Combined']['Mpg'],
      mileage: data['Response']['DataItems']['VehicleHistory']['Mileage'].to_f
    }
  end

  def self.default_data
    {
      make: 'Any',
      model: 'Any',
      make_year: 'Any',
      gearbox: 'Any',
      co2_emissions: 'Any',
      trim: 'Any',
      body_type: 'Any',
      engine_size: 'Any',
      top_speed: 'Any',
      mileage: 'Any',
      acceleration: 'Any',
      fuel_consumption: 'Any'
    }
  end
end
