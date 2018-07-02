module SearchHelper

  def search_tab_active_klass(name)
    'active' if action_name.eql?(name)
  end
end
