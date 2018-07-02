class Video
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :videographic, polymorphic: true

end
