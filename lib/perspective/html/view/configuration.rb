# -*- encoding : utf-8 -*-

module ::Perspective::HTML::View::Configuration

  include ::CascadingConfiguration::Setting
  
  #################
  #  «css_id   #
  #  «css_id=  #
  #################
  
  attr_configuration  :«css_id

  ############
  #  css_id  #
  ############

  alias_method :css_id, :«css_id

  #############
  #  css_id=  #
  #############

  alias_method :css_id=, :«css_id=
	
  ####################
  #  «css_class   #
  #  «css_class=  #
  ####################

  attr_configuration  :«css_class

  ###############
  #  css_class  #
  ###############
  
  alias_method :css_id, :«css_id
  
  ################
  #  css_class=  #
  ################
  
  alias_method :css_id=, :«css_id=
  
end
