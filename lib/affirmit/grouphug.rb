require 'affirmit/defaultframeofreference'

module AffirmIt
  
  ##
  # A group hug is a collection of affirmations (or other
  # group hugs) that a Facilitator can embrace together.
  class GroupHug
    attr_reader :name
    
    def initialize(name)
      @affirmations = []
      @name = name
    end
    
    def frame_of_reference= frame_of_reference
      @frame_of_reference = frame_of_reference
      @affirmations.each do |affirmation|
        affirmation.frame_of_reference = frame_of_reference
      end
    end
    
    def embrace facilitator
      facilitator.with_arms_around self do
        @affirmations.each do |affirmation|
          affirmation.embrace facilitator
        end
      end
    end
    
    def << affirmation
      @affirmations << affirmation
    end
    
    def affirmation_count
      @affirmations.inject(0) do |sum, affirmation|
        sum + affirmation.affirmation_count
      end
    end
  end
end
