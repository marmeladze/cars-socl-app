class Group < Entity

  field :group_type, type: Integer, default: 0 # 0 -> Open, 1 -> by_request, 2 -> private
  
  validates :group_type, inclusion: { in: [0, 1, 2] }
end
