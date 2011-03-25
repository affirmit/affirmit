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
    
    ##
    # Sets a frame of reference for all the affirmations in
    # this group hug.
    def frame_of_reference= frame_of_reference
      @affirmations.each do |affirmation|
        affirmation.frame_of_reference = frame_of_reference
      end
    end
    
    ##
    # Not to be called directly.  When a facilitator embraces
    # a group hug (or affirmation), the group hug or
    # affirmation embraces the facilitator reciprocally.
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
    
    def [] index
      @affirmations[index]
    end
    
    def each
      @affirmations.each { |affirmation| yield affirmation }
    end
    
    def each_affirmation &block
      @affirmations.each do |affirmation|
        if affirmation.is_a? GroupHug then
          affirmation.each_affirmation &block
        else
          block.call affirmation
        end
      end
    end
    
    def size
      @affirmations.size
    end
    
    ##
    # Returns the number of individual affirmations in this
    # group hug, recursively.
    def affirmation_count
      @affirmations.inject(0) do |sum, affirmation|
        sum + affirmation.affirmation_count
      end
    end
    
    def to_s
      "Group hug #{name} with #{affirmation_count} affirmations"
    end
  end
end
