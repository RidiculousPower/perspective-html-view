
require_relative '../../../../../lib/perspective/html/view.rb'

describe ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding do
  
  before :all do

    class ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::Mock
      include ::Perspective::Bindings::Container
    end
    
    class ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::FailView
      include ::Perspective::Bindings::Container
    end

    class ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::View
      include ::Perspective::HTML::View
    end
    
  end
  
  #############################
  #  __validate_view_class__  #
  #############################
  
  it 'can ensure a view class is capable of generating html' do
    
    class_binding = ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::Mock, :binding_name )
    Proc.new { class_binding.__validate_view_class__( ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::FailView ) }.should raise_error( ::Perspective::Bindings::Exception::BindingInstanceInvalidType )
    Proc.new { class_binding.__validate_view_class__( ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::View ) }.should_not raise_error
    
    Proc.new { ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::FailView ) }.should raise_error( ::Perspective::Bindings::Exception::BindingInstanceInvalidType )
    Proc.new { ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::BindingBase::ClassBinding::View ) }.should_not raise_error
    
  end
  
end
