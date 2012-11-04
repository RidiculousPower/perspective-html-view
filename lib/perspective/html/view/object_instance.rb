
module ::Perspective::HTML::View::ObjectInstance
  
  include ::Perspective::HTML::View::Configuration
  include ::Perspective::View::ObjectInstance
  
  include ::CascadingConfiguration::Setting

  #######################
  #  container_tag      #
  #  __container_tag__  #
  #######################

	attr_configuration  :__container_tag__

  Controller.alias_module_and_instance_methods( :container_tag, :__container_tag__ )

  self.__container_tag__ = :div

  ##############################
  #  __initialize_for_index__  #
  ##############################
  
  def __initialize_for_index__( index )
    
    self.__css_id__ += ( index + 1 ).to_s
    
  end

	###################################  Rendering to HTML  ##########################################

  #############
  #  to_html  #
  #############

  # return properly formatted html frame string: doctype, html and all
  def to_html
    
    html_node = to_html_node
    
    # check the root node to make sure we output valid html
    unless html_node.document_frame.root.name == 'html'
      old_root = html_node.document_frame.root
      new_root = ::Nokogiri::XML::Node.new( 'html', html_node.document_frame )
      has_head = false
      has_body = false
      head = nil
      body = nil
      content = nil
      case old_root.name
        when 'head'
          has_body = true
        when 'body'
          has_head = true
      end
      if has_head
        head = old_root
      else
        head = ::Nokogiri::XML::Node.new( 'head', html_node.document_frame )
      end
      if has_body
        body = old_root
      else
        body = ::Nokogiri::XML::Node.new( 'body', html_node.document_frame )
      end
      unless has_head or has_body
        content = old_root
        body.add_child( content )
      end
      new_root.add_child( head )
      new_root.add_child( body )
      html_node.document_frame.root = new_root
    end
    
    # Make sure that we have a head/html/body
    return html_node.document_frame.to_xhtml( self.class::FrameConfiguration )

  end
  
  ######################
  #  to_html_fragment  #
  ######################

  def to_html_fragment( view_rendering_empty = @__view_rendering_empty__ )
    
    return to_html_node( nil, view_rendering_empty ).to_s

  end

  ##################
  #  to_html_node  #
  ##################

  def to_html_node( document_frame = nil, view_rendering_empty = @__view_rendering_empty__ )

		# we are rendering a Nokogiri XML node capable of producing XML or HTML
		# this means we have to integrate data from object(s) to the view's bindings 
		# to put the data in place

    if ! binding_order_declared_empty? and __binding_order__.empty?
      raise ::Perspective::Bindings::Exception::BindingOrderEmpty,
              'Binding order was empty. Declare binding order using :attr_order.'
    end
    
    initialized_document_frame = false
    
    unless document_frame
      document_frame = __initialize_document_frame__
      initialized_document_frame = true
    end
    
		# if we have an attribute order defined that means we have child elements
		# we have to render those child elements
		nodes_from_self = __render_binding_order__( document_frame, view_rendering_empty )
    
    if initialized_document_frame
      document_frame.root = nodes_from_self
    end
    
    return nodes_from_self 
    
  end
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################

  ###################################
  #  __initialize_document_frame__  #
  ###################################

  def __initialize_document_frame__

    # We need a frame as the frame for our Node or DocumentFragment
    document_frame = ::Nokogiri::XML::Document.new
    
    # Create HTML5 DocType (<!DOCTYPE html>)
    document_frame.create_internal_subset( 'html', nil, nil )
    
		return document_frame
		
	end

  ###################################
  #  __initialize_container_node__  #
  ###################################
  
  def __initialize_container_node__( document_frame )
    
    container_node = nil
    
    # If we don't have a container tag, create contents as set of nodes
    if container_tag = __container_tag__
      container_node = ::Nokogiri::XML::Node.new( container_tag.to_s, document_frame )
    else
      container_node = ::Nokogiri::XML::NodeSet.new( document_frame )
    end
    
    # Record document frame in self-as-node
    container_node.document_frame = document_frame
    
    __initialize_css_id_and_class__( container_node )
      
    return container_node
    
  end

	#####################################
  #  __initialize_css_id_and_class__  #
  #####################################
  
  def __initialize_css_id_and_class__( container_node )
    
    if css_class = __css_class__
		  container_node[ 'class' ] = css_class.to_s	    
    end

    if css_id = __css_id__
      container_node[ 'id' ] = css_id.to_s
    end
    
  end
  	
	##############################
  #  __render_binding_order__  #
  ##############################
  
	def __render_binding_order__( document_frame, view_rendering_empty = @__view_rendering_empty__ )

		__render_value_valid__?( true, view_rendering_empty )

		# Create our container node (self)
		# This is most likely either a Div or a NodeSet, but could be anything.
    container_node = __initialize_container_node__( document_frame )

		__binding_order__.each do |this_binding_instance|

	    case html_node = this_binding_instance.to_html_node( document_frame, view_rendering_empty )
	    
	      when nil
	      
	        # nothing to do
      
	      when ::Nokogiri::XML::NodeSet
      
          html_node.each do |this_html_node|
  		      container_node << this_html_node
	        end
      
        else

  		    container_node << html_node
    
	    end

		end
		
    return container_node
    
	end
  
end
