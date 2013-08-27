# -*- encoding : utf-8 -*-

# we are using nokogiri for now, but that may change
require 'nokogiri'

[

  'view/instance_bindings/view',

  'view/configuration',
  
  '../binding_types/html',

  'view/object_and_instance_binding',
  
  '../binding_types/html_view_bindings/class_binding',
  '../binding_types/html_view_bindings/instance_binding',
  '../binding_types/html_view_bindings/view/instance_binding',
  
  'view/singleton_instance',
  'view/object_instance'
  
].each { |this_file| require_relative( this_file << '.rb' ) }
