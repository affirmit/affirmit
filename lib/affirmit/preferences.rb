require 'affirmit/preference/and'
require 'affirmit/preference/between'
require 'affirmit/preference/greaterthan'
require 'affirmit/preference/includes'
require 'affirmit/preference/is'
require 'affirmit/preference/lessthan'
require 'affirmit/preference/matches'
require 'affirmit/preference/not'
require 'affirmit/preference/or'
require 'affirmit/preference/preference'
require 'affirmit/preference/sameas'

module AffirmIt
  module Preferences
    def between(min, max)
      AffirmIt::Preference::Between.new min, max
    end
    
    def greater_than(preferred)
      AffirmIt::Preference::GreaterThan.new preferred
    end
    
    def includes(preferred)
      AffirmIt::Preference::Includes.new preferred
    end
    
    def is(preferred)
      if preferred.is_a? AffirmIt::Preference::Preference
        preferred
      else
        AffirmIt::Preference::Is.new preferred
      end
    end
    
    def less_than(preferred)
      AffirmIt::Preference::LessThan.new preferred
    end
    
    def matches(preferred)
      AffirmIt::Preference::Matches.new preferred
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
