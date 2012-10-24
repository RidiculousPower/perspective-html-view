
module ::Perspective::HTML::View::Bindings::InstanceBinding

  include ::Perspective::HTML::View::Configuration

	##################
  #  to_html_node  #
  ##################
  
	def to_html_node( document_frame = nil, view_rendering_empty = false )

		html_node = nil

    if view = __view__

  		if view.respond_to?( :to_html_node )

  		  html_node = view.to_html_node( document_frame, view_rendering_empty )
      
  		elsif view.respond_to?( :to_html_fragment )

        html_fragment = view.to_html_fragment( view_rendering_empty )
  	    html_node = ::Nokogiri::XML::DocumentFragment.parse( html_fragment )
		  
  		end

    elsif value = __value__ and
          value.respond_to?( :to_html_node )

		  html_node = value.to_html_node( document_frame, view_rendering_empty )

    elsif value.respond_to?( :to_html_fragment )
      
      html_fragment = value.to_html_fragment( view_rendering_empty )
	    html_node = ::Nokogiri::XML::DocumentFragment.parse( html_fragment )

    else

      if render_value = __render_value__( value )
        html_node = ::Nokogiri::XML::Text.new( render_value, document_frame )
  		end
	    	
		end
		
		return html_node

	end

end
