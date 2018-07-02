class SearchController < ApplicationController

  def people
    @results = AdvancedSearch.search_users(params)
  end

  def companies
    @results = AdvancedSearch.search_companies(params)
  end

  def motors
    @results = AdvancedSearch.search_motors(params)
  end

  def groups
    @results = AdvancedSearch.search_groups(params)
  end

  def events
    @results = AdvancedSearch.search_events(params)
  end

  private
  
end
