# -*- encoding : utf-8 -*-

module ::Perspective::HTML::View::ObjectInstance
  
  include ::Perspective::HTML::View::Configuration
  include ::Perspective::View::ObjectInstance
  
  include ::CascadingConfiguration::Setting
  
  #########################
  #  initialize_instance  #
  #########################

  def initialize_instance
    
    super
    
    initialize_css
    
  end

  ####################
  #  initialize_css  #
  ####################
  
  def initialize_css

    # css_class
    unless css_class = «css_class» or css_class == false
		  self.«css_class» = self.class.to_s
    end

    # css_id
    unless css_id = «css_id» or css_id == false
      if route_string = «route_string»
  	    self.«css_id» = route_string.dup
	    else
  	    self.«css_id» = '<root>'
      end
    end
    
    return self
  
  end

  ###########################
  #  self.«container_tag»   #
  #  self.«container_tag»=  #
  #  «container_tag»        #
  #  «container_tag»=       #
  ###########################

	attr_configuration  :«container_tag»

  ###########################
  #  Default Container Tag  #
  ###########################
  
  self.«container_tag» = :div

  ########################
  #  self.container_tag  #
  #  container_tag       #
  ########################

  Controller.alias_module_and_instance_methods :container_tag, :«container_tag»

  #########################
  #  self.container_tag=  #
  #  container_tag=       #
  #########################

  Controller.alias_module_and_instance_methods :container_tag=, :«container_tag»=

  ##########################
  #  initialize_for_index  #
  ##########################
  
  def initialize_for_index( index )
    
    if css_id = self.«css_id» 
      css_id << ( index + 1 ).to_s
    end
    
  end

	###################################  Rendering to HTML  ##########################################

  #############
  #  to_html  #
  #############

  # return properly formatted html frame string: doctype, html and all
  def to_html
    
    html_node = to_html_node
    
    # check the root node to make sure we output valid html
    unless html_node.document.root.name == 'html'
      old_root = html_node.document.root
      new_root = ::Nokogiri::XML::Node.new( 'html', html_node.document )
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
        head = ::Nokogiri::XML::Node.new( 'head', html_node.document )
      end
      if has_body
        body = old_root
      else
        body = ::Nokogiri::XML::Node.new( 'body', html_node.document )
      end
      unless has_head or has_body
        content = old_root
        body.add_child( content )
      end
      new_root.add_child( head )
      new_root.add_child( body )
      html_node.document.root = new_root
    end
    
    # Make sure that we have a head/html/body
    return html_node.document.to_xhtml( self.class::FrameConfiguration )

  end
  
  ######################
  #  to_html_fragment  #
  ######################

  def to_html_fragment( view_rendering_empty = @«view_rendering_empty» )
    
    return to_html_node( nil, view_rendering_empty ).to_s

  end

  ##################
  #  to_html_node  #
  ##################

  def to_html_node( document = nil, view_rendering_empty = @«view_rendering_empty» )
		
    ensure_binding_order_declared!
    
		# if we have an attribute order defined that means we have child elements
		nodes_from_self = «render_binding_order»( document, view_rendering_empty )
    
    # if we weren't passed a document, we created it and are responsible for the root node
    document.root = nodes_from_self if document
    
    return nodes_from_self 
    
  end
  
  ##################################################################################################
      private ######################################################################################
  ##################################################################################################

  #################################
  #  «initialize_container_node»  #
  #################################
  
  def «initialize_container_node»( document = nil )
    
    container_node = nil
    
    # If we don't have a container tag, create contents as set of nodes
    if container_tag = «container_tag»

      container_node = ::Nokogiri::XML::Node.new( container_tag.to_s, document )

      if css_class = «css_class»
  		  container_node[ 'class' ] = css_class.to_s	    
      end

      if css_id = «css_id»
        container_node[ 'id' ] = css_id.to_s
      end

    else

      container_node = ::Nokogiri::XML::NodeSet.new( document )

    end
      
    return container_node
    
  end
  	
	############################
  #  «render_binding_order»  #
  ############################
  
	def «render_binding_order»( document = nil, view_rendering_empty = @«view_rendering_empty» )

    ensure_required_bindings_present! unless view_rendering_empty

		# Create our container node (self)
		# This is most likely either a Div or a NodeSet, but could be anything.
    container_node = «initialize_container_node»( document )

		«binding_order».each do |this_binding|
	    case html_node = this_binding.to_html_node( document, view_rendering_empty )
	      when nil
	        # nothing to do
	      when ::Nokogiri::XML::NodeSet
          html_node.each { |this_html_node| container_node << this_html_node }
        else
  		    container_node << html_node
	    end
		end
		
    return container_node
    
	end
  
end
