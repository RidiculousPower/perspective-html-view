
require_relative '../../../../../lib/perspective/html/view.rb'

describe ::Perspective::HTML::View::Bindings::ClassBinding do
  
  before :all do

    class ::Perspective::HTML::View::Bindings::ClassBinding::Mock
      include ::Perspective::Bindings::Container
    end
    
    class ::Perspective::HTML::View::Bindings::ClassBinding::FailView
      include ::Perspective::Bindings::Container
    end

    class ::Perspective::HTML::View::Bindings::ClassBinding::View
      include ::Perspective::HTML::View
    end
    
  end
  
  #############################
  #  __validate_view_class__  #
  #############################
  
  it 'can ensure a view class is capable of generating html' do
    
    class_binding = ::Perspective::Bindings::AttributeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::ClassBinding::Mock, :binding_name )
    Proc.new { class_binding.__validate_view_class__( ::Perspective::HTML::View::Bindings::ClassBinding::FailView ) }.should raise_error( ::Perspective::Bindings::Exception::BindingInstanceInvalidType )
    Proc.new { class_binding.__validate_view_class__( ::Perspective::HTML::View::Bindings::ClassBinding::View ) }.should_not raise_error
    
    Proc.new { ::Perspective::Bindings::AttributeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::ClassBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::ClassBinding::FailView ) }.should raise_error( ::Perspective::Bindings::Exception::BindingInstanceInvalidType )
    Proc.new { ::Perspective::Bindings::AttributeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::ClassBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::ClassBinding::View ) }.should_not raise_error
    
  end
  
end
