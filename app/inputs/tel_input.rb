class TelInput < ActiveAdminAddons::InputBase

  def render_custom_input
    concat(label_html)
    concat(builder.phone_field(method, input_html_options))
  end
end
