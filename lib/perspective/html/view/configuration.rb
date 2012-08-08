
module ::Perspective::HTML::View::Configuration

  include ::CascadingConfiguration::Setting
  include ::CascadingConfiguration::Array
  
  #################
  #  css_id       #
  #  css_id=      #
  #  __css_id__   #
  #  __css_id__=  #
  #################
  
  attr_configuration  :__css_id__

  Controller.alias_module_and_instance_methods( :css_id, :__css_id__ )
	
  ####################
  #  css_class       #
  #  css_class=      #
  #  __css_class__   #
  #  __css_class__=  #
  ####################
  
  attr_configuration	:__css_class__

  Controller.alias_module_and_instance_methods( :css_class, :__css_class__ )
  
end
