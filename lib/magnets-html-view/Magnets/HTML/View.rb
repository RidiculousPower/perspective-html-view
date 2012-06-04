
module ::Magnets::HTML::View
	
	extend ::ModuleCluster

  include ::Magnets::Abstract::View

	include ::Magnets::HTML::View::ObjectInstance

	include_or_extend_cascades_prepend_extends ::Magnets::HTML::View::ClassInstance

	IndentText							=	"\t"
	IndentTextRepeatCount		= 1
	
	FrameConfiguration      = { :indent_text 	=> IndentText, 
														  :indent 			=> IndentTextRepeatCount }

end
