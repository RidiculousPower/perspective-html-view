
module ::Magnets::HTML::View::ObjectInstance
  
  include ::Magnets::HTML::View::Configuration
  include ::Magnets::Abstract::View::ObjectInstance
  
  include ::CascadingConfiguration::Setting

  ccm = ::CascadingConfiguration::Methods

  #######################
  #  container_tag      #
  #  __container_tag__  #
  #######################

	attr_configuration  :__container_tag__

  ccm.alias_module_and_instance_methods( self, :container_tag, :__container_tag__ )

  self.__container_tag__ = 'div'

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

  def to_html_fragment
    
    return to_html_node.to_s

  end

  ##################
  #  to_html_node  #
  ##################

  def to_html_node( document_frame = nil )

		# we are rendering a Nokogiri XML node capable of producing XML or HTML
		# this means we have to integrate data from object(s) to the view's bindings 
		# to put the data in place

    if ! binding_order_declared_empty? and __binding_order__.empty?
      puts 'self: ' + self.to_s
      instance_binding_parent = ::CascadingConfiguration::Variable.ancestor( self, :__binding_order__ )
      class_binding_parent = ::CascadingConfiguration::Variable.ancestor( instance_binding_parent, :__binding_order__ )
      simplemock_parent = ::CascadingConfiguration::Variable.ancestor( class_binding_parent, :__binding_order__ )
      puts 'simple: ' + instance_binding_parent.__binding_order__.to_s
      raise ::Magnets::Bindings::Exception::BindingOrderEmpty,
              'Binding order was empty. Declare binding order using :attr_order.'
    end
    
    initialized_document_frame = false
    
    unless document_frame
      document_frame = __initialize_document_frame__
      initialized_document_frame = true
    end
    
		# if we have an attribute order defined that means we have child elements
		# we have to render those child elements
		nodes_from_self = __render_binding_order__( document_frame )
    
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
    
    if container_tag = __container_tag__

      container_node = ::Nokogiri::XML::Node.new( container_tag, document_frame )
    
      # Record document frame in self-as-node
      container_node.document_frame = document_frame
      
      __initialize_css_id_and_class__( container_node )
      
    else

      container_node = ::Nokogiri::XML::NodeSet.new( document_frame )
      
    end
    
    return container_node
    
  end

	#####################################
  #  __initialize_css_id_and_class__  #
  #####################################
  
  def __initialize_css_id_and_class__( container_node )
    
    if css_class = __css_class__

		  container_node[ 'class' ] = css_class.to_s

	  else
	    
	    unless css_class == false
  		  container_node[ 'class' ] = self.class.to_s
      end
	    
    end
    
    if css_id = __css_id__

      container_node[ 'id' ] = css_id.to_s

	  else
	    
	    unless css_id == false
	      if route_string = __route_string__
  		    container_node[ 'id' ] = route_string
		    end
      end

    end
    
  end
  	
	##############################
  #  __render_binding_order__  #
  ##############################
  
	def __render_binding_order__( document_frame )
		    
		render_value_valid?( true, @__view_rendering_empty__ )

		# Create our container node (self)
		# This is most likely either a 'div' or a NodeSet, but could be anything.
    container_node = __initialize_container_node__( document_frame )

		__binding_order__.each do |this_binding_instance|
	    __render_binding__( document_frame, container_node, this_binding_instance )
		end
		
    return container_node
    
	end

	########################
  #  __render_binding__  #
  ########################
  
	def __render_binding__( document_frame, container_node, binding_instance )

    html_node = nil

	  if html_node = binding_instance.to_html_node( document_frame )

	    case html_node
	      
	      when ::Nokogiri::XML::NodeSet
        
          html_node.each do |this_html_node|
  		      container_node << this_html_node
	        end
        
        else

  		    container_node << html_node
	    
	    end

    end
    
    return html_node

  end
  
end
