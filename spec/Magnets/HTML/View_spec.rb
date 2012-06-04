
require_relative '../../../lib/magnets-html-view.rb'

describe ::Magnets::HTML::View do

  before :all do
    
    class ::Magnets::HTML::View::SimpleMock
      
      include ::Magnets::HTML::View
      
      is_a?( ::Magnets::HTML::View::ClassInstance ).should == true
      ancestors.include?( ::Magnets::HTML::View::ObjectInstance ).should == true
      attr_texts :content
      attr_text  :some_other_text
      
      attr_order :content, :some_other_text
      
    end
    
    class ::Magnets::HTML::View::Mock
      
      include ::Magnets::HTML::View
      
      attr_text  :some_view, ::Magnets::HTML::View::SimpleMock
      attr_texts :some_other_views, ::Magnets::HTML::View::SimpleMock

      attr_order :some_view, :some_other_views

    end
    
  end

	##############################
  #  __render_binding_order__  #
  ##############################

  it 'can create an array of nokogiri nodes for the declared binding order' do

    instance = ::Magnets::HTML::View::SimpleMock.new
    instance.content = 'some value'
    instance.some_other_text = 'some other value'
    node = instance.instance_eval do
      __render_binding_order__( __initialize_document_frame__ )
    end
    node.is_a?( ::Nokogiri::XML::Element ).should == true
    node.name.should == 'div'
    node.content.should == instance.content + instance.some_other_text
    
  end
  
  ##################
  #  to_html_node  #
  ##################

  it 'can render self as nokogiri html node' do
    
    instance = ::Magnets::HTML::View::Mock.new
    instance.some_view = 'some value'
    instance.some_other_views = [ ' and another value', ' and some other value' ]
    binding = instance.__binding__( :some_other_views )
    node = instance.to_html_node
    node.is_a?( ::Nokogiri::XML::Element ).should == true
    node.name.should == 'div'
    node.content.should == 'some value and another value and some other value'

  end

  ######################
  #  to_html_fragment  #
  ######################

  it 'can render self as html fragment (from nokogiri html node)' do
    instance = ::Magnets::HTML::View::Mock.new
    instance.some_view = 'some value'
    instance.some_other_views = [ ' and another value', ' and some other value' ]
    node = instance.to_html_fragment
    node.should == '<div class="Magnets::HTML::View::Mock">
  <div class="Magnets::HTML::View::SimpleMock" id="some_view">some value</div>
  <div class="Magnets::HTML::View::SimpleMock" id="some_other_views"> and another value</div>
  <div class="Magnets::HTML::View::SimpleMock" id="some_other_views2"> and some other value</div>
</div>'
  end

  #############
  #  to_html  #
  #############

  it 'can render self as html fragment (from nokogiri html node)' do
    instance = ::Magnets::HTML::View::Mock.new
    instance.some_view = 'some value'
    instance.some_other_views = [ ' and another value', ' and some other value' ]
    node = instance.to_html
    node.should == "<!DOCTYPE html>
<html xmlns=\"http://www.w3.org/1999/xhtml\">
\t<head>
\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
</head>
\t<body>
\t\t<div class=\"Magnets::HTML::View::Mock\">
\t\t\t<div class=\"Magnets::HTML::View::SimpleMock\" id=\"some_view\">some value</div>
\t\t\t<div class=\"Magnets::HTML::View::SimpleMock\" id=\"some_other_views\"> and another value</div>
\t\t\t<div class=\"Magnets::HTML::View::SimpleMock\" id=\"some_other_views2\"> and some other value</div>
\t\t</div>
\t</body>
</html>\n"
  end
  
end
