
begin ; require 'development' ; rescue ::LoadError ; end

require 'magnets/view'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './requires.rb'

# post-require setup
require_relative './setup.rb'

module ::Magnets::HTML::View
	
	extend ::Module::Cluster

  include ::Magnets::View

	include ::Magnets::HTML::View::ObjectInstance

  cluster( :magnets ).before_include_or_extend.cascade.extend( ::Magnets::HTML::View::ClassInstance )

	IndentText							=	"\t"
	IndentTextRepeatCount		= 1
	
	FrameConfiguration      = { :indent_text 	=> IndentText, 
														  :indent 			=> IndentTextRepeatCount }

end
