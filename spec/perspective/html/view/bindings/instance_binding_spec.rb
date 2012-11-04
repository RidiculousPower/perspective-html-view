
require_relative '../../../../../lib/perspective/html/view.rb'

describe ::Perspective::HTML::View::Bindings::InstanceBinding do
  
  before :all do

    class ::Perspective::HTML::View::Bindings::InstanceBinding::Mock
      include ::Perspective::Bindings::Container
    end
    
    class ::Perspective::HTML::View::Bindings::InstanceBinding::NodeView
      include ::Perspective::Bindings::Container
      def to_html_node( document_frame, view_rendering_empty )
        return ::Nokogiri::XML::DocumentFragment.parse( '<div>to_html_node_content</div>' )
      end
    end

    class ::Perspective::HTML::View::Bindings::InstanceBinding::FragmentView
      include ::Perspective::Bindings::Container
      def to_html_fragment
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
    class_binding = ::Perspective::Bindings::AttributeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::InstanceBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::InstanceBinding::NodeView )
    instance_binding = ::Perspective::Bindings::AttributeContainer::HTMLView::Text::InstanceBinding.new( class_binding, ::Perspective::HTML::View::Bindings::InstanceBinding::Mock.new )
    node = instance_binding.__to_html_node__( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::DocumentFragment ).should == true
    node.children[ 0 ].name.should == 'div'
    node.children[ 0 ].content.should == 'to_html_node_content'
    
    # with to_html_fragment
    class_binding = ::Perspective::Bindings::AttributeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::InstanceBinding::Mock, :binding_name, ::Perspective::HTML::View::Bindings::InstanceBinding::FragmentView )
    instance_binding = ::Perspective::Bindings::AttributeContainer::HTMLView::Text::InstanceBinding.new( class_binding, ::Perspective::HTML::View::Bindings::InstanceBinding::Mock.new )
    node = instance_binding.__to_html_node__( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::DocumentFragment ).should == true
    node.children[ 0 ].name.should == 'div'
    node.children[ 0 ].content.should == 'to_html_fragment_content'
    
    # with no view
    class_binding = ::Perspective::Bindings::AttributeContainer::HTMLView::Text.new( ::Perspective::HTML::View::Bindings::InstanceBinding::Mock, :binding_name )
    instance_binding = ::Perspective::Bindings::AttributeContainer::HTMLView::Text::InstanceBinding.new( class_binding, ::Perspective::HTML::View::Bindings::InstanceBinding::Mock.new )
    instance_binding.__value__ = :some_value
    node = instance_binding.__to_html_node__( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::Text ).should == true
    node.content.should == 'some_value'
    
  end
  
end
