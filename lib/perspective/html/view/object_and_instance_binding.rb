# -*- encoding : utf-8 -*-

module ::Perspective::HTML::View::ObjectAndBindingInstance

  ###########################
  #  «initialize_document»  #
  ###########################
  
  def «initialize_document»
    
    document = ::Nokogiri::XML::Document.new
    document.create_internal_subset( 'html', nil, nil )
    
    return document
    
  end
  
end
