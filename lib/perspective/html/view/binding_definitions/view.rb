
module ::Perspective::HTML::View::BindingDefinitions::View

  ##############################
  #  __binding_value_valid__?  #
  ##############################

  def __binding_value_valid__?( binding_value )
    
    binding_value_valid = false
    
    if binding_value.respond_to?( :to_html_node )     or 
       binding_value.respond_to?( :to_html_fragment )
      
      binding_value_valid = true
      
    elsif defined?( super )
      
      binding_value_valid = super
      
    end
    
    return binding_value_valid
    
  end
  
end
