module ActiveAdminAddons
  module InputMethods
    def model_name
      valid_object ? valid_object.class.to_s.underscore.tr('/', '_') : builder.object_name
    end

    def valid_method
      raise "invalid method given" if method.blank?
      method
    end

    def valid_object
      @object
    end

    def object_class
      valid_object.class
    end

    def association_name
      valid_method.to_s.singularize.chomp("_id")
    end

    def method_model
      object_class.try(:reflect_on_association, association_name).try(:klass) ||
        association_name.classify.safe_constantize || object_class
    end

    def tableize_method
      association_name.tableize
    end

    def input_related_items
      valid_object.send(tableize_method)
    rescue NoMethodError
      raise "no association called #{tableize_method} on #{model_name} model"
    end

    def input_value
      @input_value ||= valid_object.send(valid_method)
    end

    def translated_method
      valid_object.class.human_attribute_name(valid_method)
    end

    def url_from_method
      url = ["/"]

      if ActiveAdmin.application.default_namespace.present?
        url << "#{ActiveAdmin.application.default_namespace}/"
      end

      url << tableize_method
      url.join("")
    end

    def build_virtual_attr
      attribute_name = "virtual_#{valid_method}_attr"
      fail "#{attribute_name} is already defined" if valid_object.respond_to?(attribute_name)
      valid_object.singleton_class.send(:attr_accessor, attribute_name)
      attribute_name
    end
  end
end
