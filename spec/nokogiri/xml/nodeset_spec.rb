
require_relative '../../../lib/perspective/html/view.rb'

describe ::Nokogiri::XML::NodeSet do

  let( :node_set ) { ::Nokogiri::XML::NodeSet.new }
  
  it 'should automatically create its document' do
    node_set.document.should_not be nil
  end
  
end
