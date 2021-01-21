module ActiveadminAddons
  extend self

  attr_writer :default_select, :datetime_picker_default_options, :datetime_picker_input_format, :default_select_options

  def default_select
    return "select2" unless @default_select
    @default_select
  end

  def datetime_picker_default_options
    return {} unless @datetime_picker_default_options
    @datetime_picker_default_options
  end

  def datetime_picker_input_format
    return "%Y-%m-%d %H:%M" unless @datetime_picker_input_format
    @datetime_picker_input_format
  end

  def default_select_options
    {
      fields: ["name"],  predicate: "contains", display_name: 'name',
      minimum_input_length: 1, width: "80%", multiple: false,
      per_page: 30, query_extras: 'null'
    }.merge (@default_select_options || {})
  end

  def setup
    yield self
    require "activeadmin_addons"
  end
end

require_relative './activeadmin_addons/engine'
