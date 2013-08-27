# -*- encoding : utf-8 -*-

require_relative '../../../lib/perspective/html/view.rb'

require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings_test_setup.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings.rb'

describe ::Perspective::HTML::View do

  let( :bindings_module ) { ::Perspective::HTML::View }
  setup_container_and_bindings_tests( ::Perspective::HTML::View )
  
  it_behaves_like :container_and_bindings

  describe ::Perspective::BindingTypes::HTMLViewBindings::ClassBinding do

    ###########################
    #  «validate_view_class»  #
    ###########################

    context '#«validate_view_class»' do
      context 'has :to_html_node' do
        let( :view_instance_class ) do
          ::Class.new do
            def to_html_node
            end
          end
        end
        it( 'will match instances that respond to :to_html_node' ) { class_instance.•a.«validate_view_class»( view_instance_class ).should be true }
      end
      context 'has :to_html_fragment' do
        let( :view_instance_class ) do
          ::Class.new do
            def to_html_fragment
            end
          end
        end
        it( 'will match instances that respond to :to_html_fragment' ) { class_instance.•a.«validate_view_class»( view_instance_class ).should be true }
      end
      context 'has neither' do
        it 'ensures that :to_html_node or :to_html_fragment are defined' do
          ::Proc.new { class_instance.•a.«validate_view_class»( ::Object ) }.should raise_error( ::Perspective::Bindings::Exception::BindingInstanceInvalidType )
        end
      end
    end

  end

  describe ::Perspective::BindingTypes::HTMLViewBindings::InstanceBinding do
  
    ####################
    #  initialize_css  #
    ####################
  
    context '#initialize_css' do
      context 'permits_multiple? is false' do
        context 'when id and/or class explicitly set' do
          before :each do
            instance_of_class.•a.«css_id» = :a_css_id
            instance_of_class.•a.«css_class» = :a_css_class
          end
          it 'it will keep explicit setting' do
            instance_of_class.•a.«css_id».should == :a_css_id
            instance_of_class.•a.«css_class».should == :a_css_class
          end
        end
        context 'when id and/or class set to false' do
          before :each do
            instance_of_class.•a.«css_id» = false
            instance_of_class.•a.«css_class» = false
          end
          it 'will not auto-generate' do
            instance_of_class.•a.«css_id».should == false
            instance_of_class.•a.«css_class».should == false
          end
        end
        context 'when generating id and/or class' do
          it 'will auto-generate' do
            instance_of_class.•a.«css_id».should == 'a'
            instance_of_class.•a.«css_class».should == instance_of_class.•a.«container».class.to_s
          end
        end
      end
      context 'permits_multiple? is true' do
        it 'will auto-generate' do
          new_container = instance_of_multiple_container_class.multiple_binding.«create_additional_container»
          new_container.«css_id».should == 'multiple_binding2'
          new_container.«css_class».should == instance_of_multiple_container_class.multiple_binding.«container».class.to_s
        end
      end
    end
  
  end

  ##################################################################################################
  #   private ######################################################################################
  ##################################################################################################

  #################################
  #  «initialize_container_node»  #
  #################################
  
  context '#«initialize_container_node»' do
    let( :initialize_container_node ) { instance_of_class.instance_eval { «initialize_container_node» } }
    context 'when container type' do
      it 'container node will be a Node' do
        initialize_container_node.should be_a Nokogiri::XML::Node
      end
    end
    context 'when no container type' do
      before :each do
        instance_of_class.«container_tag» = nil
      end
      it 'container node will be a NodeSet' do
        initialize_container_node.should be_a Nokogiri::XML::NodeSet
      end
    end
    it 'container node will have css_id and css_class from container' do
      initialize_container_node[ 'id' ].should == instance_of_class.«css_id»
      initialize_container_node[ 'class' ].should == instance_of_class.«css_class»
    end
  end
  
  ##################################################################################################
  #   public #######################################################################################
  ##################################################################################################

  #####################
  #  «container_tag»  #
  #####################

  context '#«container_tag»' do
    it 'tracks a container tag' do
      instance_of_class.«container_tag».should == :div
    end
  end

  ######################
  #  «container_tag»=  #
  ######################

  context '#«container_tag»=' do
    it 'tracks and ca change its container tag' do
      instance_of_class.«container_tag» = 'span'
      instance_of_class.«container_tag».should == 'span'
      instance_of_class.«container_tag» = nil
      instance_of_class.«container_tag».should == nil
    end
  end

  ###################
  #  container_tag  #
  ###################

  context '#container_tag' do
    it 'is an alias for #«container_tag»' do
      ::Perspective::HTML::View.instance_method( :container_tag ).should == ::Perspective::HTML::View.instance_method( :«container_tag» )
    end
  end

  ####################
  #  container_tag=  #
  ####################

  context '#container_tag=' do
    it 'is an alias for #«container_tag»=' do
      ::Perspective::HTML::View.instance_method( :container_tag= ).should == ::Perspective::HTML::View.instance_method( :«container_tag»= )
    end
  end
  
  context '==============  Rendering  ==============' do

    let( :content_value ) { :some_content_value }
    let( :binding_one_value ) { :some_binding_one_value }
    let( :binding_two_value ) { :some_binding_two_value }
    let( :c_content_value ) { :some_c_content_value }
    let( :html_instance ) do
      class_instance.attr_order :content, :a
      class_instance.attr_autobind :content
      class_instance.css_class = :instance
      class_instance.a.attr_order :b
      class_instance.a.css_class = class_instance.a.container_class.name
      class_instance.a.b.attr_order :c
      class_instance.a.b.css_class = class_instance.a.b.container_class.name
      class_instance.a.b.c.attr_order :content
      class_instance.a.b.c.attr_autobind :content
      class_instance.a.b.c.css_class = class_instance.a.b.c.container_class.name
      instance_of_class.content = content_value
      instance_of_class.binding_one = binding_one_value
      instance_of_class.binding_two = binding_two_value
      instance_of_class.a.b.c = c_content_value
      instance_of_class
    end
    
    ##################
    #  to_html_node  #
    ##################

    context '#to_html_node' do
      let( :html_node ) { html_instance.to_html_node }
      it 'will output an HTML node reflecting its binding/container structure' do
        html_node.name.should == instance_of_class.«container_tag».to_s
        html_node.children[0].name.should == 'text'
        html_node.children[0].content.should == instance_of_class.content.to_s
        html_node.children[1].name.should == instance_of_class.•a.«container_tag».to_s
        html_node.children[1].children[0].name.should == instance_of_class.a.•b.«container_tag».to_s
        html_node.children[1].children[0].children[0].name.should == instance_of_class.a.b.•c.«container_tag».to_s
        html_node.children[1].children[0].children[0].content.should == instance_of_class.a.b.c.to_s
      end
    end
  
    ######################
    #  to_html_fragment  #
    ######################

    context '#to_html_fragment' do
      let( :html_node ) { html_instance.to_html_fragment }
      it 'will output HTML reflecting its binding/container structure (does not use full constant name for class because tests have specified name)' do
        html_node.should == '<div class="instance" id="[root]">some_content_value<div class="NestedClass_A" id="a"><div class="NestedClass_A_B" id="a::b"><div class="NestedClass_A_B_C" id="a::b::c">some_c_content_value</div></div></div></div>'
      end
    end

    #############
    #  to_html  #
    #############

    context '#to_html' do
      let( :html_node ) { html_instance.to_html }
      it 'will output a well-formed HTML5 document reflecting its binding/container structure  (does not use full constant name for class because tests have specified name)' do
        html_node.should == '<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
	<body>
		<div class="instance" id="[root]">some_content_value<div class="NestedClass_A" id="a"><div class="NestedClass_A_B" id="a::b"><div class="NestedClass_A_B_C" id="a::b::c">some_c_content_value</div></div></div></div>
	</body>
</html>
'
      end
    end
  
  end
  
end
