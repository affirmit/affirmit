require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class LessThan < AffirmIt::Preference::Preference
      def initialize expected
        @expected = expected
      end
      
      def is_preferred? actual
        actual < @expected
      end
      
      def description
        return "less than <#{@expected.inspect}>"
      end
    end
  end
end