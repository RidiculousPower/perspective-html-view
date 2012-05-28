
module ::Magnets::HTML::View::Bindings::InstanceBinding

  include ::CascadingConfiguration::Setting

  ccm = ::CascadingConfiguration::Methods

  ################
  #  css_id      #
  #  __css_id__  #
  ################
  
  attr_configuration  :__css_id__

  ccm.alias_module_and_instance_methods( self, :css_id, :__css_id__ )
	
  def __css_id__
    
    css_id = nil
    
    unless css_id  = super
      
      css_id = __route_string__
      
    end
    
    return css_id
    
  end
  
  alias_method :css_id, :__css_id__
	
  ###################
  #  css_class      #
  #  __css_class__  #
  ###################
  
  attr_configuration	:__css_class__

  ccm.alias_module_and_instance_methods( self, :css_class, :__css_class__ )
	
  def __css_class__

    css_class = nil
    
    unless css_class = super
      
      css_class = self.class.to_s
      
    end
    
    return css_class

  end

	alias_method :css_class, :__css_class__

	######################
  #  __render_value__  #
  ######################
  
	def __render_value__( document_frame, current_value = __value__ )

		html_node = nil

    if view = __view__

  		if view.respond_to?( :to_html_node )

  		  html_node = view.to_html_node( document_frame )
      
  		elsif view.respond_to?( :to_html_fragment )

  	    html_node = ::Nokogiri::XML::DocumentFragment.parse( view.to_html_fragment )
		  
  		end

    elsif current_value.respond_to?( :to_html_node )

		  html_node = __value__.to_html_node( document_frame )

    elsif current_value.respond_to?( :to_html_fragment )

	    html_node = ::Nokogiri::XML::DocumentFragment.parse( __value__.to_html_fragment )

    else

      if render_value = super( current_value )
        html_node = ::Nokogiri::XML::Text.new( render_value, document_frame )
  		end
	    	
		end
		
		return html_node

	end
	
	alias_method :render_value, :__render_value__

end
