module EntitiesHelper

  def example_text(type)
    case type
    when 'motor'
      'Red Freddy'
    when 'company'
      'Vehicles 4 All Ltd.'
    when 'event'
      'Drag event'
    when 'group'
      'Free Car Parts Group'
    end
  end

  def default_value_for(current, prop)
    current.try(prop)
  end

end
