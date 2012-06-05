
# we are using nokogiri for now, but that may change
require 'nokogiri'

require_relative '../../../abstract/view/lib/magnets-abstract-view.rb'

module ::Magnets::HTML
  module View
    module Bindings
    end
    module Attributes
    end
  end
end

basepath = 'magnets-html-view/Magnets/HTML/View'

files = [

  'Attributes/View',
  
  'Configuration',
  
  'Bindings/ClassBinding',
  'Bindings/InstanceBinding',
  'Bindings/MultiContainerProxy',
  
  'ClassInstance',
  'ObjectInstance',
  
  'NokogiriXMLNode'
  
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )

# Nokogiri extension
class Nokogiri::XML::Node
  include ::Magnets::Abstract::View::NokogiriXMLNode
end

module ::Magnets::Bindings::AttributeContainer::HTMLView::ClassBinding
  include ::Magnets::HTML::View::Bindings::ClassBinding
end

module ::Magnets::Bindings::AttributeContainer::HTMLView::InstanceBinding
  include ::Magnets::HTML::View::Bindings::InstanceBinding
end

class ::Magnets::Bindings::Container::MultiContainerProxy
  include ::Magnets::HTML::View::Bindings::MultiContainerProxy
end
