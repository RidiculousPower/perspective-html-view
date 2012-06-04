
module ::Magnets::HTML::View::Bindings::MultiContainerProxy

  #################
  #  css_id       #
  #  css_id=      #
  #  __css_id__   #
  #  __css_id__=  #
  #################

  attr_accessor :__css_id__

  alias_method :css_id, :__css_id__
  alias_method :css_id=, :__css_id__=

  ####################
  #  css_class       #
  #  css_class=      #
  #  __css_class__   #
  #  __css_class__=  #
  ####################

  attr_accessor :__css_class__

  alias_method :css_class, :__css_class__
  alias_method :css_class=, :__css_class__=

  ##################
  #  autobind      #
  #  __autobind__  #
  ##################

  def __autobind__( *data_objects )

    container_class = nil

    # if we don't already have a css class and id set for self, set it from first view
    unless __css_id__
      self.__css_id__ = self[ 0 ].__css_id__
    end

    unless __css_class__
      self.__css_class__ = self[ 0 ].__css_class__
    end
    
    return super
    
  end
  
  ##################
  #  to_html_node  #
  ##################

  def to_html_node( document_frame )

    html_nodes = ::Nokogiri::XML::NodeSet.new( document_frame )
    
    @__storage_array__.each_with_index do |this_view, this_index|

      unless this_view.__css_id__
        if css_id = __css_id__
          this_view.__css_id__ = css_id.to_s + ( this_index + 1 ).to_s
        end
      end

      unless this_view.__css_class__
        if css_class = __css_class__
          this_view.__css_class__ = css_class
        end
      end

      output_node = this_view.to_html_node
      html_nodes << output_node
    end

    return html_nodes
    
  end

end
