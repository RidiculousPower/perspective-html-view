# -*- encoding : utf-8 -*-

require 'perspective/view'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

module ::Perspective::HTML::View
	
  include ::Perspective::View
	include ::Perspective::HTML::View::ObjectInstance

	extend ::Module::Cluster
  cluster( :perspective ).before_include_or_extend.cascade.extend( ::Perspective::HTML::View::SingletonInstance )

	IndentText							=	"\t"
	IndentTextRepeatCount		= 1
	
	FrameConfiguration      = { :indent_text 	=> IndentText, 
														  :indent 			=> IndentTextRepeatCount }

end
