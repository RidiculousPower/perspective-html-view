# -*- encoding : utf-8 -*-

require_relative '../../../lib/perspective/html/view.rb'

require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings_test_setup.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/container_and_bindings_spec/container_and_bindings.rb'

describe ::Perspective::HTML::View do

  let( :bindings_module ) { ::Perspective::HTML::View }
  setup_container_and_bindings_tests  
  
#  it_behaves_like :container_and_bindings

  describe ::Perspective::BindingTypes::HTMLBindings::ClassBinding do

    ##########################
    #  «validate_view_class  #
    ##########################

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

  ################################
  #  «initialize_container_node  #
  ################################
  
  context '#«initialize_container_node' do
    let( :initialize_container_node ) { instance_of_class.instance_eval { «initialize_container_node } }
    context 'when container type' do
      it 'container node will be a Node' do
        initialize_container_node.should be_a Nokogiri::XML::Node
      end
    end
    context 'when no container type' do
      before :each do
        instance_of_class.«container_tag = nil
      end
      it 'container node will be a NodeSet' do
        initialize_container_node.should be_a Nokogiri::XML::NodeSet
      end
    end
    it 'container node will have css_id and css_class from container' do
      initialize_container_node[ 'id' ].should == instance_of_class.«css_id
      initialize_container_node[ 'class' ].should == instance_of_class.«css_class
    end
  end
  
  ##################################################################################################
  #   public #######################################################################################
  ##################################################################################################

  ####################
  #  «container_tag  #
  ####################

  context '#«container_tag' do
    it 'tracks a container tag' do
      instance_of_class.«container_tag.should == 'div'
    end
  end

  #####################
  #  «container_tag=  #
  #####################

  context '#«container_tag=' do
    it 'tracks and ca change its container tag' do
      instance_of_class.«container_tag = 'span'
      instance_of_class.«container_tag.should == 'span'
      instance_of_class.«container_tag = nil
      instance_of_class.«container_tag.should == nil
    end
  end

  ###################
  #  container_tag  #
  ###################

  context '#container_tag' do
    it 'is an alias for #«container_tag' do
      ::Perspective::HTML::View.instance_method( :container_tag ).should == ::Perspective::HTML::View.instance_method( :«container_tag )
    end
  end

  ####################
  #  container_tag=  #
  ####################

  context '#container_tag=' do
    it 'is an alias for #«container_tag=' do
      ::Perspective::HTML::View.instance_method( :container_tag= ).should == ::Perspective::HTML::View.instance_method( :«container_tag= )
    end
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
  
end
