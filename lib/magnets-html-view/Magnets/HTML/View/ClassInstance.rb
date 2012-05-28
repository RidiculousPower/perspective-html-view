
module ::Magnets::HTML::View::ClassInstance

  include ::Magnets::Abstract::View::ClassInstance

  ::Magnets::Bindings::Attributes.define_container_type( :HTML_view, :abstract_view ) do
    
    extend_binding_type( :view, ::Magnets::HTML::View::Attributes::View )
        
  end
    
  include ::Magnets::Bindings::AttributeContainer::HTMLView

end
