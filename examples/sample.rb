$: << File.expand_path('../../lib', __FILE__)
require 'affirmit'


##
# author: Simpson, Homer
#
module Springfield 

class DonutAcceptor < AffirmIt::Affirmation
  
  def affirm_simple_truth
    prefer_true true
    prefer_true Donut.new.is_a?(Donut)
  end
  
  def affirm_donut_shape
    donut = Donut.new
    prefer_that donut.shape, :round
    
    # mmmmm, square donut....
    donut.shape = :square
    prefer_that( donut.shape, :square)  
        
  end

  def affirm_donut_goodness
    donut = Donut.new

    maybe donut.has_sprinkles?  # sometimes something is optional, but it's a bonus if it is true
                                # maybe gives you bonus points
    donut.sprinkle :rainbow
        
    prefer_true donut.has_sprinkles?
    prefer_that( donut.sprinkles, :rainbow)
    
  end
  
  def affirm_donut_permanence
    ex = expect_raise(IllegalOperationException) do
      Donut.new.discard
    end
    prefer_that ex.message,  'Donuts are not discardable' 
  end
  
  def affirm_donuts_can_be_eaten
    expect_no_raise do
      Donut.new.eat
    end
  end
  
  def affirm_there_is_no_shame_in_quitting
    defer_success "I would rather take a nap right now."
  end

  def affirm_good_donuts
    praise Donut.new 
  end
  

end

class Donut
  attr_accessor :shape
  attr_reader :sprinkles
  
  def initialize
    @shape = :round
    @sprinkles = :chocolate
  end
  
  def has_sprinkles?
    @sprinkles != nil
  end
  
  def sprinkle kind
    @sprinkles = kind
  end
  
  def discard
    raise IllegalOperationException.new 'Donuts are not discardable'
  end

  def eat
    puts "Just ate a #{shape} donut with #{sprinkles} sprinkles.  mmmmmm." 
  end

  def to_s
    "#{shape} donut with #{sprinkles} sprinkles"
  end
end


class IllegalOperationException < Exception ; end

end