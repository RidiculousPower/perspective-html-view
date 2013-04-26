# -*- encoding : utf-8 -*-

module ::Perspective::HTML::View::Configuration

  include ::CascadingConfiguration::Setting
  
  ###########################
  #  self.«container_tag»   #
  #  self.«container_tag»=  #
  #  «container_tag»        #
  #  «container_tag»=       #
  ###########################

	attr_configuration  :«container_tag»

  #############################
  #  «container_tag» Default  #
  #############################
  
  self.«container_tag» = :div

  ########################
  #  self.container_tag  #
  #  container_tag       #
  ########################

  self::Controller.alias_module_and_instance_methods :container_tag, :«container_tag»

  #########################
  #  self.container_tag=  #
  #  container_tag=       #
  #########################

  self::Controller.alias_module_and_instance_methods :container_tag=, :«container_tag»=

  ###############
  #  «css_id»   #
  #  «css_id»=  #
  ###############
  
  attr_configuration  :«css_id»

  ############
  #  css_id  #
  ############

  self::Controller.alias_module_and_instance_methods :css_id, :«css_id»

  #############
  #  css_id=  #
  #############

  self::Controller.alias_module_and_instance_methods :css_id=, :«css_id»=
	
  ##################
  #  «css_class»   #
  #  «css_class»=  #
  ##################

  attr_configuration  :«css_class»

  ###############
  #  css_class  #
  ###############
  
  self::Controller.alias_module_and_instance_methods :css_class, :«css_class»
  
  ################
  #  css_class=  #
  ################
  
  self::Controller.alias_module_and_instance_methods :css_class=, :«css_class»=
  
end
