class PhotoPost < Post

  embeds_one :photo, as: :photographic, cascade_callbacks: true
  accepts_nested_attributes_for :photo, allow_destroy: true
end
