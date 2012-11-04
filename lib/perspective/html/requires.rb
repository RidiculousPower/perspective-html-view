
# we are using nokogiri for now, but that may change
require 'nokogiri'

basepath = 'view'

files = [

  'attributes/view',
  
  'configuration',
  
  'bindings/class_binding',
  'bindings/instance_binding',
  'bindings/multi_container_proxy',
  
  'class_instance',
  'object_instance',
  
  'nokogiri_xml_node',
  'nokogiri_xml_nodeset'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end
