
module ::Perspective::BindingTypes::HTMLBindings::ClassBinding

  include ::Perspective::HTML::View::Configuration
      
  #############################
  #  __validate_view_class__  #
  #############################

  def __validate_view_class__( view_class )
    	  
    unless view_class.method_defined?( :to_html_node )     or 
           view_class.method_defined?( :to_html_fragment )

      raise ::Perspective::Bindings::Exception::BindingInstanceInvalidType,
              'View class specified (' + view_class.to_s + ') does not respond to either ' +
              ':to_html_node or :to_html_fragment.'
    end
    
    super
    
  end

end
