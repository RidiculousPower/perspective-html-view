
module ::Magnets::HTML::View::Bindings::ClassBinding
      
  #############################
  #  __validate_view_class__  #
  #############################

  def __validate_view_class__( view_class )
    	  
    unless view_class.method_defined?( :to_html_node )     or 
           view_class.method_defined?( :to_html_fragment )

      raise ::Magnets::Bindings::Exception::BindingInstanceInvalidTypeError,
              'View class specified (' + view_class.to_s + ') does not respond to either ' +
              ':to_html_node or :to_html_fragment.'
    end
    
    super
    
  end

end
