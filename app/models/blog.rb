class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :blogable, polymorphic: true

end
