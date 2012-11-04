
module ::Perspective::HTML::View::Bindings::InstanceBinding

  include ::Perspective::HTML::View::Configuration

  #############################
  #  __configure_container__  #
  #############################
  
  def __configure_container__( bound_container = nil )
  
    __configure_container_css_id__
    
    super
    
  end
  
  ####################################
  #  __configure_container_css_id__  #
  ####################################
  
  def __configure_container_css_id__( container_instance = __container__ )
  
    if container_instance

      container_css_id = container_instance.__css_id__   
      
      unless container_css_id or container_css_id == false

  	    self.__css_id__ = __route_string__
      end
    
      container_css_class = container_instance.__css_class__   

	    unless container_css_class or container_css_class == false
  		  self.__css_class__ = container_instance.class.to_s
      end
    
    end    
    
    return self
  
  end
    
  ######################################
  #  __create_multi_container_proxy__  #
  ######################################
  
  def __create_multi_container_proxy__( data_object )

    __container__.__css_id__ += '1'
    
    return super
    
  end

	##################
  #  to_html_node  #
  ##################
  
	def to_html_node( document_frame = nil, view_rendering_empty = @__view_rendering_empty__ )

		html_node = nil

    if view = __view__

  		if view.respond_to?( :to_html_node )

  		  html_node = view.to_html_node( document_frame, view_rendering_empty )

  		elsif view.respond_to?( :to_html_fragment )

        html_fragment = view.to_html_fragment( view_rendering_empty )
        # there doesn't appear to be a way to include a chunk of raw html
        # so we have to parse it and create nodes to include it
  	    html_node = ::Nokogiri::XML::DocumentFragment.parse( html_fragment )
		  
  		end

    elsif value = __value__
      
      if value.respond_to?( :to_html_node )

		    html_node = value.to_html_node( document_frame, view_rendering_empty )
      
      elsif value.respond_to?( :to_html_fragment )
      
        html_fragment = value.to_html_fragment( view_rendering_empty )
  	    html_node = ::Nokogiri::XML::DocumentFragment.parse( html_fragment )
      
      elsif render_value = __render_value__( value )
        
        html_node = ::Nokogiri::XML::Text.new( render_value, document_frame )
    	
    	end
	    	
		end
		
		return html_node

	end

end
