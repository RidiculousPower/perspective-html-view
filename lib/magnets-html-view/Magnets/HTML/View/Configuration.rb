
module ::Magnets::HTML::View::Configuration

  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array
  
  ccm = ::CascadingConfiguration::Methods
  
  #######################
  #  binding_order      #
  #  __binding_order__  #
  #######################
  
  attr_configuration_array  :__binding_order__

  ccm.alias_module_and_instance_methods( self, :binding_order, :__binding_order__ )
  
  #################
  #  css_id       #
  #  css_id=      #
  #  __css_id__   #
  #  __css_id__=  #
  #################
  
  attr_configuration  :__css_id__

  ccm.alias_module_and_instance_methods( self, :css_id, :__css_id__ )
	
  ####################
  #  css_class       #
  #  css_class=      #
  #  __css_class__   #
  #  __css_class__=  #
  ####################
  
  attr_configuration	:__css_class__

  ccm.alias_module_and_instance_methods( self, :css_class, :__css_class__ )
  
end
