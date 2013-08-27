# -*- encoding : utf-8 -*-

module ::Perspective::HTML::View::Configuration

  extend ::CascadingConfiguration::Setting
  
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

  alias_method :container_tag, :«container_tag»

  #########################
  #  self.container_tag=  #
  #  container_tag=       #
  #########################

  alias_method :container_tag=, :«container_tag»=

  ###############
  #  «css_id»   #
  #  «css_id»=  #
  ###############
  
  attr_configuration  :«css_id»

  ############
  #  css_id  #
  ############

  alias_method :css_id, :«css_id»

  #############
  #  css_id=  #
  #############

  alias_method :css_id=, :«css_id»=
	
  ##################
  #  «css_class»   #
  #  «css_class»=  #
  ##################

  attr_configuration  :«css_class»

  ###############
  #  css_class  #
  ###############
  
  alias_method :css_class, :«css_class»
  
  ################
  #  css_class=  #
  ################
  
  alias_method :css_class=, :«css_class»=
  
end
