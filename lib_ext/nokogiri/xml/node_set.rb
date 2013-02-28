
class ::Nokogiri::XML::NodeSet

  include ::Perspective::HTML::View::Nokogiri::InitializeDocument
  
  #########################
  #  nokogiri_initialize  #
  #########################
  
  alias_method :nokogiri_initialize, :initialize

  ################
  #  initialize  #
  ################
  
  def initialize( document = nil, list = [ ] )
    
    document ||= initialize_document
    
    nokogiri_initialize( document, list )
        
  end

end
