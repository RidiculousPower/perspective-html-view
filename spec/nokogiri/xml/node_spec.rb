# -*- encoding : utf-8 -*-

require_relative '../../../lib/perspective/html/view.rb'

describe ::Nokogiri::XML::Node do

  let( :node ) { ::Nokogiri::XML::Node.new( 'div' ) }
  
  it 'should automatically create its document' do
    node.document.should_not be nil
  end
  
end
