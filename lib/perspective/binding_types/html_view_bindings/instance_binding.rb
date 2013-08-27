# -*- encoding : utf-8 -*-

module ::Perspective::BindingTypes::HTMLViewBindings::InstanceBinding

  include ::Perspective::HTML::View::Configuration
  include ::Perspective::HTML::View::ObjectAndBindingInstance

  ################
  #  initialize  #
  ################

  def initialize( parent_class_binding, bound_container_instance )
    
    super
    
    initialize_css
    
  end

  ####################
  #  initialize_css  #
  ####################
  
  def initialize_css
  
    # css_class
    unless css_class = «css_class» or css_class == false
		  self.«css_class» = container.class.to_s if container = «container»
    end

    # css_id
    unless css_id = «css_id» or css_id == false
	    self.«css_id» = «route_string».dup
    end
    
    return self
  
  end
  
	##################
  #  to_html_node  #
  ##################
  
	def to_html_node( document = «initialize_document», view_rendering_empty = @«view_rendering_empty» )

		html_node = nil
		
		if permits_multiple? and «view_count» > 1
		  
		  html_node = ::Nokogiri::XML::NodeSet.new( document )
      each { |this_view| html_node << this_view.to_html_node }
	    
	  elsif view = «view»
	    
	    if view.respond_to?( :to_html_node )

  		  html_node = view.to_html_node( document, view_rendering_empty )

  		elsif view.respond_to?( :to_html_fragment )

        html_fragment = view.to_html_fragment( view_rendering_empty )
        # there doesn't appear to be a way to include a chunk of raw html
        # so we have to parse it and create nodes to include it
  	    html_node = ::Nokogiri::XML::DocumentFragment.parse( html_fragment )
	  
  		end
  		
    elsif value = «value»

      if value.respond_to?( :to_html_node )

		    html_node = value.to_html_node( document, view_rendering_empty )

      elsif value.respond_to?( :to_html_fragment )

        html_fragment = value.to_html_fragment( view_rendering_empty )
  	    html_node = ::Nokogiri::XML::DocumentFragment.parse( html_fragment )

      elsif render_value = «render_value»( value )

        html_node = ::Nokogiri::XML::Text.new( render_value, document )

    	end
	    
    end

		return html_node

	end

end
