
require_relative '../../../../lib/perspective/html/view.rb'

require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/binding_definitions/binding_definition_test_setup.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/binding_definitions/text.rb'
require_relative ::File.join ::Perspective::Bindings.spec_location, 'perspective/bindings/binding_definitions/number.rb'

describe ::Perspective::HTML::View::BindingDefinitions::View do

  setup_binding_definition_tests
  let( :binding_definition_module ) { ::Perspective::HTML::View::BindingDefinitions::View }
  
  it_behaves_like :text_container_binding
  it_behaves_like :number_container_binding  

  let( :view_instance_class ) do
    view_instance_class = ::Class.new { include ::Perspective::View }
    view_instance_class.name( :ViewInstanceClass )
    view_instance_class
  end
  
  let( :view_instance ) { view_instance_class.new }

  ##############################
  #  __binding_value_valid__?  #
  ##############################

  context '#__binding_value_valid__?' do
    context 'has :to_html_node' do
      it 'will report true' do
      end
    end
    context 'has :to_html_fragment' do
      it 'will report true' do
      end
    end
    context 'has neither' do
      it 'will report false' do
      end
    end
  end

end
