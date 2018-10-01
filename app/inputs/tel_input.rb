class TelInput < ActiveAdminAddons::InputBase

  def render_custom_input
    concat(label_html)
    virtual_attr = build_virtual_attr
    concat(builder.phone_field(virtual_attr, virtual_input_html_options(virtual_attr.to_s)))
  end

  def load_control_attributes
    load_data_attr(:hidden_input, value: method.to_s)
  end

  def virtual_input_html_options(id)
    input_html_options.merge!({
      id: id,
      class: 'tel-input',
      value: @object[method]
    })
  end

end
