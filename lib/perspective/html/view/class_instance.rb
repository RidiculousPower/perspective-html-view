
module ::Perspective::HTML::View::ClassInstance
  
  ::Perspective::Bindings::Attributes.define_container_type( :HTML_view, true, :abstract_view ) do
    
    extend_binding_type( :view,             ::Perspective::HTML::View::Attributes::View )
        
  end
    
  include ::Perspective::Bindings::AttributeContainer::HTMLView

  #########
  #  new  #
  #########
  
  def new( *args )
    
    instance = super

    instance.__css_class__ = non_nested_class.to_s
	  
    return instance
    
  end

end
