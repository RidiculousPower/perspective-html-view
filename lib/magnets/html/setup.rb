
# Nokogiri extension
class Nokogiri::XML::Node
  include ::Magnets::View::NokogiriXMLNode
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
