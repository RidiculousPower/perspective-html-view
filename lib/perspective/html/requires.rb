# -*- encoding : utf-8 -*-

# we are using nokogiri for now, but that may change
require 'nokogiri'

files = [

  'view/binding_definitions/view',

  'view/configuration',
  
  '../binding_types/html',
  
  '../binding_types/html_bindings/class_binding',
  '../binding_types/html_bindings/instance_binding',
  '../binding_types/html_bindings/view/instance_binding',
  
  'view/singleton_instance',
  'view/object_instance',

  'view/nokogiri/initialize_document',
  '../../../lib_ext/nokogiri/xml/node',
  '../../../lib_ext/nokogiri/xml/node_set'

  
]

files.each { |this_file| require_relative( this_file << '.rb' ) }
