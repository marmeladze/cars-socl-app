class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :photographic, polymorphic: true

  mount_uploader :file, PhotoUploader
  validates_presence_of :file
end
