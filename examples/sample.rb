require File.expand_path("../lib/esteem.rb")


##
# author: Simpson, Homer
#
module PowerPlantOperationsAcceptor 

class DonutAcceptor
  include AffirmIt::Esteem
  
  def embrace_simple_truth
    prefer_true true
    prefer_true Donut.new.is_a?(Donut)
  end
  
  def embrace_donut_shape
    donut = Donut.new
    prefer_that donut.shape, :round
    
    # mmmmm, square donut....
    donut.shape = :square
    prefer_that( donut.shape, :square)  
        
  end

  def embrace_donut_goodness
    donut = Donut.new

    maybe donut.has_sprinkles?  # sometimes something is optional, but it's a bonus if it is true
                                # maybe gives you bonus points
    donut.sprinkle :rainbow
        
    prefer_true donut.has_sprinkles?
    prefer_that( donut.sprinkles, :rainbow)
    
  end
  
  def embrace_donut_permanence
    ex = expect_raise(PowerPlantRuleViolation) do
      Donut.new.discard
    end
    prefer_that ex.message,  'Donuts are not discardable' 
  end
  
  def embrace_donuts_can_be_eaten
    expect_no_raise do
      Donut.new.eat
    end
  end
  
  def embrace_there_is_no_shame_in_quitting
    defer_success "I would rather take a nap right now."
  end

  def embrace_good_donuts
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
    raise PowerPlantRuleViolation.new 'Donuts are not discardable'
  end

  def eat
    puts "Just ate a #{shape} donut with #{sprinkles} sprinkles.  mmmmmm." 
  end

  def to_s
    "#{shape} donut with #{sprinkles} sprinkles"
  end
end


class PowerPlantRuleViolation < Exception ; end

end


# until we get the runner working, just do it explicitly here...

da  = PowerPlantOperationsAcceptor::DonutAcceptor.new
da.embrace_simple_truth
da.embrace_donut_shape
da.embrace_donut_goodness
da.embrace_donut_permanence
da.embrace_donuts_can_be_eaten
da.embrace_good_donuts
da.embrace_there_is_no_shame_in_quitting

