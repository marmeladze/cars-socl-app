class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :categorizable, polymorphic: true

  field :name,  type: String
  field :make,  type: String
  field :model, type: String
  field :trim,  type: String
  field :year,  type: String

  validates :make, uniqueness: { scope: [:model] }
  validates :name, inclusion: { in: %w(Car Bike Boat Plane Helicopter Other) }

  def tag_name
    "#{make} #{model}"
  end
end
