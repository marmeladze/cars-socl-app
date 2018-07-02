class UkVehicleData
  include Mongoid::Document
  include Mongoid::Timestamps

  field :model_id, type: Integer
  field :model_make_id, type: String
  field :model_name, type: String
  field :model_trim, type: String
  field :model_year, type: Integer
  field :model_body, type: String
  field :model_engine_position, type: String
  field :model_engine_cc, type: Integer
  field :model_engine_cyl, type: Integer
  field :model_engine_type, type: String
  field :model_engine_valves_per_cyl, type: Integer
  field :model_engine_power_ps, type: Integer
  field :model_engine_power_rpm, type: Integer
  field :model_engine_torque_nm, type: Integer
  field :model_engine_torque_rpm, type: Integer
  field :model_engine_bore_mm, type: Float
  field :model_engine_stroke_mm, type: Float
  field :model_engine_compression, type: String
  field :model_engine_fuel, type: String
  field :model_top_speed_kph, type: Integer
  field :model_0_to_100_kph, type: Float
  field :model_drive, type: String
  field :model_transmission_type, type: String
  field :model_seats, type: Integer
  field :model_doors, type: Integer
  field :model_weight_kg, type: Integer
  field :model_length_mm, type: Integer
  field :model_width_mm, type: Integer
  field :model_height_mm, type: Integer
  field :model_wheelbase_mm, type: Integer
  field :model_lkm_hwy, type: Float
  field :model_lkm_mixed, type: Float
  field :model_lkm_city, type: Float
  field :model_fuel_cap_l, type: Integer
  field :model_sold_in_us, type: Integer
  field :model_co2, type: Integer
  field :model_make_display, type: String


  def self.seed_data(file_path=nil)
    UkVehicleData.delete_all
    file_path ||= Rails.public_path.join('CQA_Premium.csv')
    CSV.foreach(file_path) do |row|
      row = row.map { |x| x.to_s.strip }
      data = UkVehicleData.create(prepare_object(row))
      if data.errors.present?
        puts "Error while seeding data for record: #{row}"
      end
    end
  end

  def self.prepare_object(row)
    {
      model_id: row[0],
      model_make_id: row[1],
      model_name: row[2],
      model_trim: row[3],
      model_year: row[4],
      model_body: row[5],
      model_engine_position: row[6],
      model_engine_cc: row[7],
      model_engine_cyl: row[8],
      model_engine_type: row[9],
      model_engine_valves_per_cyl: row[10],
      model_engine_power_ps: row[11],
      model_engine_power_rpm: row[12],
      model_engine_torque_nm: row[13],
      model_engine_torque_rpm: row[14],
      model_engine_bore_mm: row[15],
      model_engine_stroke_mm: row[16],
      model_engine_compression: row[17],
      model_engine_fuel: row[18],
      model_top_speed_kph: row[19],
      model_0_to_100_kph: row[20],
      model_drive: row[21],
      model_transmission_type: row[22],
      model_seats: row[23],
      model_doors: row[24],
      model_weight_kg: row[25],
      model_length_mm: row[26],
      model_width_mm: row[27],
      model_height_mm: row[28],
      model_wheelbase_mm: row[29],
      model_lkm_hwy: row[30],
      model_lkm_mixed: row[31],
      model_lkm_city: row[32],
      model_fuel_cap_l: row[33],
      model_sold_in_us: row[34],
      model_co2: row[35],
      model_make_display: row[36]
    }
  end
end
