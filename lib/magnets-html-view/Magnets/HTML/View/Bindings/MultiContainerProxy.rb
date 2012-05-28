
module ::Magnets::HTML::View::Bindings::MultiContainerProxy

  ######################
  #  to_html_node      #
  #  __to_html_node__  #
  ######################

  def __to_html_node__( document_frame )

    html_nodes = ::Nokogiri::XML::NodeSet.new( document_frame )
    
    @__storage_array__.each do |this_view|
      output_node = this_view.to_html_node
      html_nodes << output_node
    end

    return html_nodes
    
  end

  alias_method :to_html_node, :__to_html_node__

end
