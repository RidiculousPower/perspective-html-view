
# Nokogiri extension
class Nokogiri::XML::Node
  include ::Perspective::HTML::View::NokogiriXMLNode
end
class Nokogiri::XML::NodeSet
  include ::Perspective::HTML::View::NokogiriXMLNodeSet
end

module ::Perspective::Bindings::AttributeContainer::HTMLView::ClassBinding
  include ::Perspective::HTML::View::Bindings::ClassBinding
end

module ::Perspective::Bindings::AttributeContainer::HTMLView::InstanceBinding
  include ::Perspective::HTML::View::Bindings::InstanceBinding
end

class ::Perspective::Bindings::Container::MultiContainerProxy
  include ::Perspective::HTML::View::Bindings::MultiContainerProxy
end
