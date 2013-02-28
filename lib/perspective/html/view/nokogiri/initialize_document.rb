
module ::Perspective::HTML::View::Nokogiri::InitializeDocument

	#########################
  #  initialize_document  #
  #########################

  def initialize_document

    # We need a document as the frame for our Node or DocumentFragment
    document = ::Nokogiri::XML::Document.new
    
    # Create HTML5 DocType (<!DOCTYPE html>)
    document.create_internal_subset( 'html', nil, nil )
    
		return document
		
	end
  
end