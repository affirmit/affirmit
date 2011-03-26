module AffirmIt
  module Preference
    
    ##
    # A Preference is a condition that can be preferred by an
    # affirmation.  The code being affirmed may choose to prefer
    # the same opinion or not.  If the two opinions differ, the
    # facilitator will make note of the differing opinion with
    # the description returned by this preference.
    class Preference
      ##
      # Determines whether the actual value agrees with this
      # preference.
      def is_preferred? actual
        return true
      end
      
      ##
      # If #is_preferred? returns false, this method will be
      # called in order to generate a description of this
      # preference, in an overall description like:
      #
      # "preferred description, but was <actual>"
      def description
        return ''
      end
    end
    
  end
end
