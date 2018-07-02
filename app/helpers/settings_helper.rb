module SettingsHelper

  def settings_active_klass(name)
    'active' if action_name.eql?(name)
  end

  def countries_list
    CS.countries.map { |code, name| [name, code.downcase] }
  end

  def privacy_options
    PrivacyPreference::VISIBILITY.each_with_index.map { |option, i| [option, i] }
  end
end
