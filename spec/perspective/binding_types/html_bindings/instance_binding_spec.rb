
require_relative '../../../../../lib/perspective/html/view.rb'

describe ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding do
  
  before :all do

    class ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::Mock
      include ::Perspective::Bindings::Container
    end
    
    class ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::NodeView
      include ::Perspective::Bindings::Container
      def to_html_node( document, view_rendering_empty )
        return ::Nokogiri::XML::DocumentFragment.parse( '<div>to_html_node_content</div>' )
      end
    end

    class ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::FragmentView
      include ::Perspective::Bindings::Container
      def to_html_fragment( view_rendering_empty )
        return '<div>to_html_fragment_content</div>'
      end
    end

  end
  
	##################
  #  to_html_node  #
  ##################
  
  it 'can render its view class and/or value' do
    
    mock_doc_frame = ::Nokogiri::XML::Document.new
    
    # with to_html_node
    class_binding = ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::NodeView )
    instance_binding = ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text::InstanceBinding.new( class_binding, ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::Mock.new )
    node = instance_binding.to_html_node( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::DocumentFragment ).should == true
    node.children[ 0 ].name.should == 'div'
    node.children[ 0 ].content.should == 'to_html_node_content'
    
    # with to_html_fragment
    class_binding = ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::FragmentView )
    instance_binding = ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text::InstanceBinding.new( class_binding, ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::Mock.new )
    node = instance_binding.to_html_node( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::DocumentFragment ).should == true
    node.children[ 0 ].name.should == 'div'
    node.children[ 0 ].content.should == 'to_html_fragment_content'
    
    # with no view
    class_binding = ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::Mock, :binding_name )
    instance_binding = ::Perspective::Bindings::BindingTypeContainer::HTMLView::Text::InstanceBinding.new( class_binding, ::Perspective::HTML::View::Bindings::BindingBase::InstanceBinding::Mock.new )
    instance_binding.__value__ = :some_value
    node = instance_binding.to_html_node( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::Text ).should == true
    node.content.should == 'some_value'
    
  end
  
end
