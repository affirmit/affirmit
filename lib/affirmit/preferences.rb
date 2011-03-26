require 'affirmit/preference/and'
require 'affirmit/preference/between'
require 'affirmit/preference/greaterthan'
require 'affirmit/preference/includes'
require 'affirmit/preference/is'
require 'affirmit/preference/isa'
require 'affirmit/preference/lessthan'
require 'affirmit/preference/matches'
require 'affirmit/preference/not'
require 'affirmit/preference/or'
require 'affirmit/preference/preference'
require 'affirmit/preference/sameas'

module AffirmIt
  ##
  # The Preferences module includes DSL-like methods
  # to help affirmations express their preferences.
  #
  # For example:
  #
  # is(5)
  # between(4, 6)
  # (greater_than 3) & (less_than 7)
  # (is a String) | (is a Fixnum)
  module Preferences
    def a(preferred_class)
      AffirmIt::Preference::IsA.new preferred_class
    end
    
    def an(preferred_class)
      AffirmIt::Preference::IsA.new preferred_class
    end
    
    def between(min, max)
      AffirmIt::Preference::Between.new min, max
    end
    
    def equals(preferred)
      AffirmIt::Preference::Is.new preferred
    end
    
    def greater_than(preferred)
      AffirmIt::Preference::GreaterThan.new preferred
    end
    
    def includes(preferred)
      AffirmIt::Preference::Includes.new preferred
    end
    
    ##
    # If we have learned anything from
    # lawyer-politicians, it is that everything
    # depends on your definition of "is"....
    #
    # In this case, the "is" method helps with
    # legibility of affirmations.  Feel free to
    # re-implement with your preferred discourse on
    # being.  We're certain you'll do a great job!
    def is(preferred)
      if preferred.is_a? AffirmIt::Preference::Preference
        preferred
      else
        AffirmIt::Preference::Is.new preferred
      end
    end
    
    def isnt(preferred)
      ~is(preferred)
    end
    
    def less_than(preferred)
      AffirmIt::Preference::LessThan.new preferred
    end
    
    def matches(preferred_regexp)
      AffirmIt::Preference::Matches.new preferred_regexp
    end
    
    def same_as(preferred)
      AffirmIt::Preference::SameAs.new preferred
    end
  end
  
  ##
  # Add &, | and ~ methods (instead of and, or and not,
  # which we cannot redefine) to combine Preferences.
  module Preference
    class Preference
      def & other
        return And.new self, other
      end
      
      def | other
        return Or.new self, other
      end
      
      def ~
        return Not.new self
      end
    end
  end
end
