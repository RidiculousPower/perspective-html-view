
module ::Perspective::HTML::View::Configuration

  include ::CascadingConfiguration::Setting
  
  #################
  #  __css_id__   #
  #  __css_id__=  #
  #################
  
  attr_configuration  :__css_id__

  ############
  #  css_id  #
  ############

  alias_method :css_id, :__css_id__

  #############
  #  css_id=  #
  #############

  alias_method :css_id=, :__css_id__=
	
  ####################
  #  __css_class__   #
  #  __css_class__=  #
  ####################

  attr_configuration  :__css_class__

  ###############
  #  css_class  #
  ###############
  
  alias_method :css_id, :__css_id__
  
  ################
  #  css_class=  #
  ################
  
  alias_method :css_id=, :__css_id__=
  
end
