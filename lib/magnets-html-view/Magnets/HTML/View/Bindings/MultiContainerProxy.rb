
module ::Magnets::HTML::View::Bindings::MultiContainerProxy
  
  ##################
  #  to_html_node  #
  ##################

  def to_html_node( document_frame )

    html_nodes = ::Nokogiri::XML::NodeSet.new( document_frame )
    
    @__storage_array__.each_with_index do |this_view, this_index|

      unless css_id = this_view.__css_id__ or
             css_id == false

        this_view.__css_id__ = @__parent_binding__.__route_string__.to_s + ( this_index + 1 ).to_s
      
      end

      output_node = this_view.to_html_node
      
      html_nodes << output_node
      
    end

    return html_nodes
    
  end

end
