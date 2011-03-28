$: << File.expand_path('../../lib', __FILE__)
require 'affirmit'

class Dead < Exception; end

class Unicorn
  attr_reader :life_force, :locations

  def initialize
    @life_force = 10
    @locations = []
  end

  def is_dead?
    @life_force <= 0
  end

  def prance location
    @locations << location
    @life_force -= 3
    raise Dead if @life_force < 0 # return Zombie.new
  end
end

class UnicornAffirmation < AffirmIt::Affirmation
  def build_up
    @unicorn = Unicorn.new
  end

  def affirm_life_force
    prefer_that @unicorn.life_force, is(10)
  end

  def affirm_prance_adds_location
    prefer_that @unicorn.locations.empty?
    @unicorn.prance :fields
    @unicorn.prance :flowery_meadows
    prefer_that @unicorn.locations, (includes :fields) & (includes :flowery_meadows)
  end

  def affirm_prance_too_much_can_be_fatal
    3.times { @unicorn.prance :fields }
    prefer_that @unicorn.life_force, greater_than(0)
    expect_raise Dead do
      @unicorn.prance :killing_fields
    end
    maybe @unicorn.is_dead?
  end
end
