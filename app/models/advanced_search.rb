class AdvancedSearch

  def self.search_users(params)
    results = User.all
    if(params[:advanced_search] == 'true')
      results = results.where(name: /#{params[:name]}/i) if has_param?(params[:name])
      results = results.where(email: /#{params[:email]}/i) if has_param?(params[:email])
      results = results.where(username: /#{params[:username]}/i) if has_param?(params[:username])
      results = results.where(city: /#{params[:city]}/i) if has_param?(params[:city])
      results = results.where(state: /#{params[:state]}/i) if has_param?(params[:state])
      results = results.where(country: /#{params[:country]}/i) if has_param?(params[:country])
    elsif has_param?(params[:term])
      results = results.any_of(
        {name: /#{params[:term]}/i},
        {username: /#{params[:term]}/i},
        {email: /#{params[:term]}/i}
      )
    end
    results
  end

  def self.search_motors(params)
    results = Motor.all
    if(params[:advanced_search] == 'true')
      results = results.where(motor_category: /#{params[:motor_category]}/i) if has_param?(params[:motor_category])
      results = results.where(reg_no: /#{params[:reg_no]}/i) if has_param?(params[:reg_no])
      results = results.where(make: /#{params[:make]}/i) if has_param?(params[:make])
      results = results.where(model: /#{params[:model]}/i) if has_param?(params[:model])
      results = results.where(body_type: /#{params[:body_type]}/i) if has_param?(params[:body_type])
      results = results.where(engine_size: /#{params[:engine_size]}/i) if has_param?(params[:engine_size])
      # results = filterer(:acceleration, params)
      # results = filterer(:co2_emissions, params)
      # results = filterer(:top_speed, params)
      # results = filterer(:fuel_consumption, params)    
    else
      results = results.any_of(
        {'motor_category' => /#{params[:term]}/i},
        {'reg_no'         => /#{params[:term]}/i},
        {'make'           => /#{params[:term]}/i},
        {'model'          => /#{params[:term]}/i},
        {'body_type'      => /#{params[:term]}/i},
      )
    end
    results
  end

  def self.search_companies(params)
    results = Company.all
    if(params[:advanced_search] == 'true')
      results = results.where('profile.name' => /#{params[:name]}/i) if has_param?(params[:name])
      results = results.where('address.address' => /#{params[:address]}/i) if has_param?(params[:address])
    else
      results = results.any_of(
        {'profile.name' => /#{params[:term]}/i},
        {'address.address' => /#{params[:term]}/i}
      )
    end
    results
  end

  def self.search_groups(params)
    results = Group.all
    if(params[:advanced_search] == 'true')
      results = results.where('profile.name' => /#{params[:name]}/i) if has_param?(params[:name])
    else
      results = results.where('profile.name' => /#{params[:term]}/i) if has_param?(params[:term])
    end
    results
  end

  def self.search_events(params)
    results = Event.all
    if(params[:advanced_search] == 'true')
      results = results.where('event_date' => /#{params[:event_date]}/i) if has_param?(params[:event_date])
      results = results.where('profile.name' => /#{params[:name]}/i) if has_param?(params[:name])
      results = results.where('address.address' => /#{params[:address]}/i) if has_param?(params[:address])
    else
      results = results.any_of(
        {'profile.name' => /#{params[:term]}/i},
        {'address.address' => /#{params[:term]}/i}
      )
    end
    results
  end

  private

  def self.has_param?(param)
    !param.nil? && !param.strip.empty?
  end
end
