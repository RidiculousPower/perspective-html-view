
module ::Perspective::HTML::View::SingletonInstance
    
  include ::Perspective::BindingTypes::HTMLBindings

  #########################
  #  initialize_instance  #
  #########################
  
  def initialize_instance( instance )
    
    super
    
    instance.__css_class__ = to_s
    
    return instance
    
  end

end
