# -*- encoding : utf-8 -*-

require_relative '../../../../../lib/perspective/html/view.rb'

require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/instance_bindings/binding_definition_test_setup.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/instance_bindings/text.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/instance_bindings/number.rb'

describe ::Perspective::HTML::View::InstanceBindings::View do

  setup_binding_definition_tests
  let( :binding_definition_module ) { ::Perspective::HTML::View::InstanceBindings::View }
  
  it_behaves_like :text_container_binding
  it_behaves_like :number_container_binding  

  let( :view_instance_class ) do
    view_instance_class = ::Class.new { include ::Perspective::HTML::View }
    view_instance_class.name( :HTMLViewInstanceClass )
    view_instance_class
  end
  
  let( :view_instance ) { view_instance_class.new }

  ##########################
  #  binding_value_valid?  #
  ##########################

  context '#binding_value_valid?' do
    context 'has :to_html_node' do
      let( :view_instance_class ) do
        ::Class.new do
          def to_html_node
          end
        end
      end
      it( 'will match instances that respond to :to_html_node' ) { should match_types( view_instance ) }
    end
    context 'has :to_html_fragment' do
      let( :view_instance_class ) do
        ::Class.new do
          def to_html_fragment
          end
        end
      end
      it( 'will match instances that respond to :to_html_node' ) { should match_types( view_instance ) }
    end
    context 'has neither' do
      it( 'will report false' ) { should_not match_types( Object.new ) }
    end
  end

end
