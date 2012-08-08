
begin ; require 'development' ; rescue ::LoadError ; end

require 'perspective/view'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

# post-require setup
require_relative './setup.rb'

module ::Perspective::HTML::View
	
	extend ::Module::Cluster

  include ::Perspective::View

	include ::Perspective::HTML::View::ObjectInstance

  cluster( :perspective ).before_include_or_extend.cascade.extend( ::Perspective::HTML::View::ClassInstance )

	IndentText							=	"\t"
	IndentTextRepeatCount		= 1
	
	FrameConfiguration      = { :indent_text 	=> IndentText, 
														  :indent 			=> IndentTextRepeatCount }

end
