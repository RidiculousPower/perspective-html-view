
module ::Magnets::HTML::View::Bindings::InstanceBinding

  include ::Magnets::HTML::View::Configuration

	##################
  #  to_html_node  #
  ##################
  
	def to_html_node( document_frame, current_value = __value__ )

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

      if render_value = __render_value__( current_value )
        html_node = ::Nokogiri::XML::Text.new( render_value, document_frame )
  		end
	    	
		end
		
		return html_node

	end

end
