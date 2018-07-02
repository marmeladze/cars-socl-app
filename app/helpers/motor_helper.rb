module MotorHelper

  def prepare_select_field(name, values=[])
    label_tag = content_tag(:label, for: "motor#{name.camelize}") { name.humanize.titleize }
    select_tag = content_tag(:select, id: "motor#{name.camelize}", name: "motor[#{name}]", class: 'selectpicker', prompt: "Select #{name.humanize.titleize}") do
      options = [content_tag(:option, value: nil) { "Select #{name.humanize.titleize}" }]
      values.each do |value|
        options << content_tag(:option, value: value) { value }
      end
      options.join.html_safe
    end
    line_break = content_tag(:div, nil, class: 'form-control-border')
    content_tag(:div, class: 'col-md-4 col-xs-12') do
      content_tag(:div, class: 'form-group') do
        (label_tag + select_tag + line_break).html_safe
      end
    end
  end

  def in_dreamgarage?(user, motor)
    user.dream_garage.motors.where(id: motor.id.to_s).first.present?
  end
end
