# -*- encoding : utf-8 -*-

# we are using nokogiri for now, but that may change
require 'nokogiri'

files = [

  'view/instance_bindings/view',

  'view/configuration',
  
  '../binding_types/html',

  'view/object_and_instance_binding',
  
  '../binding_types/html_bindings/class_binding',
  '../binding_types/html_bindings/instance_binding',
  '../binding_types/html_bindings/view/instance_binding',
  
  'view/singleton_instance',
  'view/object_instance'
  
]

files.each { |this_file| require_relative( this_file << '.rb' ) }
