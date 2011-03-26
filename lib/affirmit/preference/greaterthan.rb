require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class GreaterThan < AffirmIt::Preference::Preference
      def initialize expected
        @expected = expected
      end
      
      def is_preferred? actual
        actual > @expected
      end
      
      def description
        return "greater than <#{@expected.inspect}>"
      end
    end
  end
end