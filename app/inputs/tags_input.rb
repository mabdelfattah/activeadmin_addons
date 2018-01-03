<<<<<<< HEAD
class TagsInput < Formtastic::Inputs::SelectInput
  def input_html_options
    opts = {}
    opts[:class] = "select2-tags"
    opts["data-width"] = @options[:width] if @options[:width]
    super.merge(opts)
  end

  def to_html
    relation? ? render_tags_from_relation : render_tags
  end
=======
class TagsInput < ActiveAdminAddons::InputBase
  include ActiveAdminAddons::SelectHelpers
>>>>>>> 683fc44b97c82f9e02adb3ad6a74bb788338d3e2

  def render_custom_input
    if active_record_select?
      return render_collection_tags
    end

    render_array_tags
  end

  def load_control_attributes
    load_data_attr(:model, value: model_name)
    load_data_attr(:method, value: method)
    load_data_attr(:width, default: "80%")

    if active_record_select?
      load_data_attr(:relation, value: true)
      load_data_attr(:collection, value: collection_to_select_options, formatter: :to_json)
    else
      load_data_attr(:collection, value: array_to_select_options, formatter: :to_json)
    end
  end

  private

  def render_array_tags
    render_tags_control { build_hidden_control(prefixed_method, method_to_input_name, input_value) }
  end

  def render_collection_tags
    render_tags_control { render_selected_hidden_items }
  end

  def render_tags_control(&block)
    concat(label_html)
    concat(block.call)
    concat(builder.select(build_virtual_attr, [], {}, input_html_options))
  end

  def render_selected_hidden_items
    template.content_tag(:div, id: selected_values_id) do
      template.concat(build_hidden_control(empty_input_id, method_to_input_array_name, ""))
      input_value.each do |item_id|
        template.concat(
          build_hidden_control(
            method_to_input_id(item_id),
            method_to_input_array_name,
            item_id.to_s
          )
        )
      end
    end
  end
end
