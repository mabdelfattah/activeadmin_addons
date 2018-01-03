<<<<<<< HEAD
class SearchSelectInput < Formtastic::Inputs::SelectInput
  def input_html_options
    relation = !@object.nil? ? @object.send(attributized_method_name) : ''
    opts = {}
    opts[:class] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || []).to_json
    opts["data-url"] = @options[:url] || ""
    opts["data-response_root"] = @options[:response_root] || @options[:url].to_s.split('/').last
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1
    opts["data-width"] = @options[:width] if @options[:width]
    opts["data-selected"] = relation.try(opts["data-display_name"].to_sym)
    opts["data-order"] = @options[:order_by] if @options[:order_by]
    opts["data-per_page"] = @options[:per_page] if @options[:per_page]
    if @options[:multiple]
      opts["data-multiple"] = 'true'
      opts[:name] = super[:name] + '[]'
    end
    super.merge opts
=======
class SearchSelectInput < ActiveAdminAddons::InputBase
  include ActiveAdminAddons::SelectHelpers

  def render_custom_input
    concat(label_html)
    concat(builder.select(input_method,
      initial_collection_to_select_options, {}, input_html_options))
  end

  def input_method
    valid_method
  end

  def load_control_attributes
    load_class(@options[:class])
    load_data_attr(:fields, default: ["name"], formatter: :to_json)
    load_data_attr(:url, default: url_from_method)
    load_data_attr(:response_root, default: tableize_method)
    load_data_attr(:display_name, default: "name")
    load_data_attr(:minimum_input_length, default: 1)
    load_data_attr(:width, default: "80%")
    load_data_attr(
      :order,
      value: @options[:order_by],
      default: get_data_attr_value(:fields).first.to_s + "_desc"
    )
>>>>>>> 683fc44b97c82f9e02adb3ad6a74bb788338d3e2
  end

  def collection
    if !@object.nil?
      { get_selected_value => @object[method] }
    else
      { '': '' }
    end
  end

  def get_selected_value(display_name = @options[:display_name] || "name")
    @object.send(attributized_method_name).send(display_name) rescue ''
  end
end
