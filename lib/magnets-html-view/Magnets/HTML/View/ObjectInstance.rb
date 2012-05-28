
module ::Magnets::HTML::View::ObjectInstance
  
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
	

	###################################  Rendering to HTML  ##########################################

  #################
  #  to_html      #
  #  __to_html__  #
  #################

  # return properly formatted html frame string: doctype, html and all
  def __to_html__
    
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
  
  alias_method :to_html, :__to_html__

  ##########################
  #  to_html_fragment      #
  #  __to_html_fragment__  #
  ##########################

  def __to_html_fragment__
    
    return to_html_node.to_s

  end

  alias_method :to_html_fragment, :__to_html_fragment__

  ######################
  #  to_html_node      #
  #  __to_html_node__  #
  ######################

  def __to_html_node__( document_frame = nil )

		# we are rendering a Nokogiri XML node capable of producing XML or HTML
		# this means we have to integrate data from object(s) to the view's bindings 
		# to put the data in place

    if ! binding_order_declared_empty? and __binding_order__.empty?
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

  alias_method :to_html_node, :__to_html_node__
  
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
      
      if css_class = __css_class__
  		  container_node[ 'class' ] = css_class
      end
      if css_id = __css_id__
        container_node[ 'id' ] = css_id
      end
      
    else

      container_node = ::Nokogiri::XML::NodeSet.new( document_frame )
      
    end
    
    return container_node
    
  end
  	
	##############################
  #  __render_binding_order__  #
  ##############################
  
	def __render_binding_order__( document_frame )
		    
		# Create our container node (self)
		# This is most likely either a 'div' or a NodeSet, but could be anything.
    container_node = __initialize_container_node__( document_frame )
    
		__binding_order__.each do |this_binding_instance|

		  if html_node = this_binding_instance.__render_value__( document_frame )

		    case html_node
		      
  	      when ::Nokogiri::XML::NodeSet
          
            html_node.each do |this_html_node|
    		      container_node << this_html_node
  	        end
	        
          else

    		    container_node << html_node
		    
		    end

	    end
	    
		end
		
    return container_node
    
	end
  
end
