
module ::Perspective::HTML::View::ClassInstance
  
  ::Perspective::Bindings::Attributes.define_container_type( :HTML_view, true, :abstract_view ) do
    
    extend_binding_type( :view,             ::Perspective::HTML::View::Attributes::View )
        
  end
    
  include ::Perspective::Bindings::AttributeContainer::HTMLView

end
