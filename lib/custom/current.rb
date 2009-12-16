module Custom
  module Current
    
    def generate_model
      @generate_model ||= instance_variable_set(current_instance_sym, current_model.find(params[:id]))
    end

    def current_instance_sym
      :"@#{current_identifier.singularize}"
    end

    def current_instances_sym
      :"@#{current_identifier}"
    end

    def current_sym
      :"#{current_identifier.singularize}"
    end

    def current_identifier
      @current_controller ||= params[:controller].sub(/admin\//, "")
    end

    def current_model
      @current_model ||= current_identifier.classify.constantize
    end
  end
end
