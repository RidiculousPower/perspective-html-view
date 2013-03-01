# -*- encoding : utf-8 -*-

require_relative '../../../lib/perspective/html/view.rb'

require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings_test_setup.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings.rb'

describe ::Perspective::HTML::View do

  let( :bindings_module ) { ::Perspective::HTML::View }
  setup_container_and_bindings_tests  
  
#  it_behaves_like :container_and_bindings

  describe ::Perspective::BindingTypes::HTMLBindings::ClassBinding do

    #############################
    #  «validate_view_class  #
    #############################

    context '#«validate_view_class' do
      context 'has :to_html_node' do
        let( :view_instance_class ) do
          ::Class.new do
            def to_html_node
            end
          end
        end
        it( 'will match instances that respond to :to_html_node' ) { class_instance.a.«validate_view_class( view_instance_class ).should be true }
      end
      context 'has :to_html_fragment' do
        let( :view_instance_class ) do
          ::Class.new do
            def to_html_fragment
            end
          end
        end
        it( 'will match instances that respond to :to_html_fragment' ) { class_instance.a.«validate_view_class( view_instance_class ).should be true }
      end
      context 'has neither' do
        it 'ensures that :to_html_node or :to_html_fragment are defined' do
          ::Proc.new { class_instance.a.«validate_view_class( ::Object ) }.should raise_error( ::Perspective::Bindings::Exception::BindingInstanceInvalidType )
        end
      end
    end

  end

  describe ::Perspective::BindingTypes::HTMLBindings::InstanceBinding do

    ####################
    #  initialize_css  #
    ####################

    context '#initialize_css' do
      context 'permits_multiple? is false' do
        context 'when id and/or class explicitly set' do
          before :each do
            instance_of_class.a.«css_id = :a_css_id
            instance_of_class.a.«css_class = :a_css_class
          end
          it 'it will keep explicit setting' do
            instance_of_class.a.«css_id.should == :a_css_id
            instance_of_class.a.«css_class.should == :a_css_class
          end
        end
        context 'when id and/or class set to false' do
          before :each do
            instance_of_class.a.«css_id = false
            instance_of_class.a.«css_class = false
          end
          it 'will not auto-generate' do
            instance_of_class.a.«css_id.should == false
            instance_of_class.a.«css_class.should == false
          end
        end
        context 'when generating id and/or class' do
          it 'will auto-generate' do
            instance_of_class.a.«css_id.should == 'a'
            instance_of_class.a.«css_class.should == instance_of_class.a.«container.class.to_s
          end
        end
      end
      context 'permits_multiple? is true' do
        it 'will auto-generate' do
          new_container = instance_of_multiple_container_class.multiple_binding.«create_additional_container
          new_container.«css_id.should == 'multiple_binding2'
          new_container.«css_class.should == instance_of_multiple_container_class.multiple_binding.«container.class.to_s
        end
      end
    end

  end

  ##################################################################################################
  #   private ######################################################################################
  ##################################################################################################

  ###################################
  #  «initialize_container_node  #
  ###################################
  
  context '#«initialize_container_node' do
  end
  
	##############################
  #  «render_binding_order  #
  ##############################

  context '#«render_binding_order' do
  end

  ##################################################################################################
  #   public #######################################################################################
  ##################################################################################################

  #######################
  #  «container_tag  #
  #######################

  context '#«container_tag' do
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
  #  initialize_for_index  #
  ##############################
  
  context '#initialize_for_index' do
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
  #  «render_binding_order  #
  ##############################

  it 'can create an array of nokogiri nodes for the declared binding order' do

    instance = ::Perspective::HTML::View::SimpleMock.new
    instance.content = 'some value'
    instance.some_other_text = 'some other value'
    node = instance.instance_eval do
      «render_binding_order( «initialize_document )
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
