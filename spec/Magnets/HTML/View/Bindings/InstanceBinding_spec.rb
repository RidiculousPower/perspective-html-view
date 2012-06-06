
require_relative '../../../../../lib/magnets-html-view.rb'

describe ::Magnets::HTML::View::Bindings::InstanceBinding do
  
  before :all do

    class ::Magnets::HTML::View::Bindings::InstanceBinding::NodeView
      include ::Magnets::Bindings::Container
      def to_html_node( document_frame )
        return ::Nokogiri::XML::DocumentFragment.parse( '<div>to_html_node_content</div>' )
      end
    end

    class ::Magnets::HTML::View::Bindings::InstanceBinding::FragmentView
      include ::Magnets::Bindings::Container
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
    class_binding = ::Magnets::Bindings::AttributeContainer::HTMLView::Text.new( :binding_name, ::Magnets::HTML::View::Bindings::InstanceBinding::NodeView )
    instance_binding = ::Magnets::Bindings::AttributeContainer::HTMLView::Text::InstanceBinding.new( class_binding, Object.new )
    node = instance_binding.to_html_node( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::DocumentFragment ).should == true
    node.children[ 0 ].name.should == 'div'
    node.children[ 0 ].content.should == 'to_html_node_content'
    
    # with to_html_fragment
    class_binding = ::Magnets::Bindings::AttributeContainer::HTMLView::Text.new( :binding_name, ::Magnets::HTML::View::Bindings::InstanceBinding::FragmentView )
    instance_binding = ::Magnets::Bindings::AttributeContainer::HTMLView::Text::InstanceBinding.new( class_binding, Object.new )
    node = instance_binding.to_html_node( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::DocumentFragment ).should == true
    node.children[ 0 ].name.should == 'div'
    node.children[ 0 ].content.should == 'to_html_fragment_content'
    
    # with no view
    class_binding = ::Magnets::Bindings::AttributeContainer::HTMLView::Text.new( :binding_name )
    instance_binding = ::Magnets::Bindings::AttributeContainer::HTMLView::Text::InstanceBinding.new( class_binding, Object.new )
    instance_binding.__value__ = :some_value
    node = instance_binding.to_html_node( mock_doc_frame )
    node.is_a?( ::Nokogiri::XML::Text ).should == true
    node.content.should == 'some_value'
    
  end
  
end
