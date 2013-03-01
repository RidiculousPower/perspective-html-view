# -*- encoding : utf-8 -*-

class ::Nokogiri::XML::Node

  extend ::Perspective::HTML::View::Nokogiri::InitializeDocument
 
  #######################
  #  self.nokogiri_new  #
  #######################

  alias_singleton_method :nokogiri_new, :new

  ##############
  #  self.new  #
  ##############
  
  def self.new( tag, document = nil )

    return nokogiri_new( tag, document || initialize_document )
    
  end
  
end
