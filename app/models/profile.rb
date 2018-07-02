class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :details, polymorphic: true

  field :name, type: String
  field :about, type: String

  mount_uploader :avatar, PhotoUploader
  mount_uploader :cover_pic, PhotoUploader

end
