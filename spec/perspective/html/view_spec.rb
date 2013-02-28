
require_relative '../../../lib/perspective/html/view.rb'

require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings_test_setup.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings.rb'

describe ::Perspective::HTML::View do

  describe ::Perspective::BindingTypes::HTMLBindings::ClassBinding do

    #############################
    #  __validate_view_class__  #
    #############################

    context '#__validate_view_class__' do
      it 'ensures that :to_html_node or :to_html_fragment are defined' do
        puts 'class: ' + class_instance.a.class.to_s
        # 1. if subclassing does not happen for first, do not do for later
        # 2. type container for type does not match
        ::Proc.new { class_instance.a.__validate_view_class__( ::Object ) }.should raise_error( ::Perspective::Bindings::Exception::BindingInstanceInvalidType )
      end
    end

  end

  describe ::Perspective::BindingTypes::HTMLBindings::InstanceBinding do

    #############################
    #  __configure_container__  #
    #############################

    context '#__configure_container__' do
    end

    ####################################
    #  __configure_container_css_id__  #
    ####################################

    context '#__configure_container_css_id__' do
    end

    ######################################
    #  __create_multi_container_proxy__  #
    ######################################

    context '#__create_multi_container_proxy__' do
    end

  	##################
    #  to_html_node  #
    ##################

    context '#to_html_node' do
    end

  end

  ##################################################################################################
  #   private ######################################################################################
  ##################################################################################################

  ###################################
  #  __initialize_container_node__  #
  ###################################
  
  context '#__initialize_container_node__' do
  end

	#####################################
  #  __initialize_css_id_and_class__  #
  #####################################
  
  context '#__initialize_css_id_and_class__' do
  end
  
	##############################
  #  __render_binding_order__  #
  ##############################

  context '#__render_binding_order__' do
  end

  ##################################################################################################
  #   public #######################################################################################
  ##################################################################################################

  #######################
  #  __container_tag__  #
  #######################

  context '#__container_tag__' do
  end

  ###################
  #  container_tag  #
  ###################

  context '#container_tag' do
  end

  ####################
  #  container_tag=  #
  ####################

  context '#container_tag=' do
  end

  ##############################
  #  __initialize_for_index__  #
  ##############################
  
  context '#__initialize_for_index__' do
  end

  #############
  #  to_html  #
  #############

  context '#to_html' do
  end
  
  ######################
  #  to_html_fragment  #
  ######################

  context '#to_html_fragment' do
  end

  ##################
  #  to_html_node  #
  ##################

  context '#to_html_node' do
  end
  








  before :all do
    
    class ::Perspective::HTML::View::SimpleMock
      
      include ::Perspective::HTML::View
      
      is_a?( ::Perspective::HTML::View::SingletonInstance ).should == true
      ancestors.include?( ::Perspective::HTML::View::ObjectInstance ).should == true
      attr_texts :content
      attr_text  :some_other_text
      
      attr_order :content, :some_other_text
      
    end
    
    class ::Perspective::HTML::View::Mock
      
      include ::Perspective::HTML::View
      
      attr_text  :some_view, ::Perspective::HTML::View::SimpleMock
      
      attr_texts :some_other_views, ::Perspective::HTML::View::SimpleMock

      attr_order :some_view, :some_other_views

    end
    
  end

	##############################
  #  __render_binding_order__  #
  ##############################

  it 'can create an array of nokogiri nodes for the declared binding order' do

    instance = ::Perspective::HTML::View::SimpleMock.new
    instance.content = 'some value'
    instance.some_other_text = 'some other value'
    node = instance.instance_eval do
      __render_binding_order__( __initialize_document__ )
    end
    node.is_a?( ::Nokogiri::XML::Element ).should == true
    node.name.should == 'div'
    node.content.should == instance.content + instance.some_other_text
    
  end
  
  ##################
  #  to_html_node  #
  ##################

  it 'can render self as nokogiri html node' do
    
    instance = ::Perspective::HTML::View::Mock.new

    instance.some_view = 'some value'
    instance.some_other_views = [ ' and another value', ' and some other value' ]

    node = instance.to_html_node

    node.is_a?( ::Nokogiri::XML::Element ).should == true
    node.name.should == 'div'
    node[ 'class' ].should == 'Perspective::HTML::View::Mock'

    node.children[ 0 ].name.should == 'div'
    node.children[ 0 ][ 'class' ].should == 'Perspective::HTML::View::SimpleMock'
    node.children[ 0 ][ 'id' ].should == 'some_view'
    node.children[ 0 ].content.should == 'some value'

    node.children[ 1 ].name.should == 'div'
    node.children[ 1 ][ 'class' ].should == 'Perspective::HTML::View::SimpleMock'
    node.children[ 1 ][ 'id' ].should == 'some_other_views1'
    node.children[ 1 ].content.should == ' and another value'

    node.children[ 2 ].name.should == 'div'
    node.children[ 2 ][ 'class' ].should == 'Perspective::HTML::View::SimpleMock'
    node.children[ 2 ][ 'id' ].should == 'some_other_views2'
    node.children[ 2 ].content.should == ' and some other value'
    
    node.content.should == 'some value and another value and some other value'

  end

  ######################
  #  to_html_fragment  #
  ######################

  it 'can render self as html fragment (from nokogiri html node)' do
    instance = ::Perspective::HTML::View::Mock.new
    instance.some_view = 'some value'
    instance.some_other_views = [ ' and another value', ' and some other value' ]
    fragment = instance.to_html_fragment
    fragment.should == '<div class="Perspective::HTML::View::Mock">
  <div class="Perspective::HTML::View::SimpleMock" id="some_view">some value</div>
  <div class="Perspective::HTML::View::SimpleMock" id="some_other_views1"> and another value</div>
  <div class="Perspective::HTML::View::SimpleMock" id="some_other_views2"> and some other value</div>
</div>'
  end

  #############
  #  to_html  #
  #############

  it 'can render self as html fragment (from nokogiri html node)' do
    instance = ::Perspective::HTML::View::Mock.new
    instance.some_view = 'some value'
    instance.some_other_views = [ ' and another value', ' and some other value' ]
    node = instance.to_html
    node.should == "<!DOCTYPE html>
<html xmlns=\"http://www.w3.org/1999/xhtml\">
\t<head>
\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
</head>
\t<body>
\t\t<div class=\"Perspective::HTML::View::Mock\">
\t\t\t<div class=\"Perspective::HTML::View::SimpleMock\" id=\"some_view\">some value</div>
\t\t\t<div class=\"Perspective::HTML::View::SimpleMock\" id=\"some_other_views1\"> and another value</div>
\t\t\t<div class=\"Perspective::HTML::View::SimpleMock\" id=\"some_other_views2\"> and some other value</div>
\t\t</div>
\t</body>
</html>\n"
  end
  
end
