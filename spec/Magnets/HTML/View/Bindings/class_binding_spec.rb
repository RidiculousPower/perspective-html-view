
require_relative '../../../../../lib/magnets-html-view.rb'

describe ::Magnets::HTML::View::Bindings::ClassBinding do
  
  before :all do

    class ::Magnets::HTML::View::Bindings::ClassBinding::Mock
      include ::Magnets::Bindings::Container
    end
    
    class ::Magnets::HTML::View::Bindings::ClassBinding::FailView
      include ::Magnets::Bindings::Container
    end

    class ::Magnets::HTML::View::Bindings::ClassBinding::View
      include ::Magnets::HTML::View
    end
    
  end
  
  #############################
  #  __validate_view_class__  #
  #############################
  
  it 'can ensure a view class is capable of generating html' do
    
    class_binding = ::Magnets::Bindings::AttributeContainer::HTMLView::Text.new( ::Magnets::HTML::View::Bindings::ClassBinding::Mock, :binding_name )
    Proc.new { class_binding.__validate_view_class__( ::Magnets::HTML::View::Bindings::ClassBinding::FailView ) }.should raise_error( ::Magnets::Bindings::Exception::BindingInstanceInvalidType )
    Proc.new { class_binding.__validate_view_class__( ::Magnets::HTML::View::Bindings::ClassBinding::View ) }.should_not raise_error
    
    Proc.new { ::Magnets::Bindings::AttributeContainer::HTMLView::Text.new( ::Magnets::HTML::View::Bindings::ClassBinding::Mock, :binding_name, ::Magnets::HTML::View::Bindings::ClassBinding::FailView ) }.should raise_error( ::Magnets::Bindings::Exception::BindingInstanceInvalidType )
    Proc.new { ::Magnets::Bindings::AttributeContainer::HTMLView::Text.new( ::Magnets::HTML::View::Bindings::ClassBinding::Mock, :binding_name, ::Magnets::HTML::View::Bindings::ClassBinding::View ) }.should_not raise_error
    
  end
  
end
