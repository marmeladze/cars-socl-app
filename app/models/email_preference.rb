class EmailPreference
  include Mongoid::Document
  include Mongoid::Timestamps

  field :someone_tags_me, type: Boolean, default: false
  field :new_comment, type: Boolean, default: false
  field :new_group_activity, type: Boolean, default: false

  embedded_in :user
end
