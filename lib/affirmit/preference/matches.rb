require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class Matches < AffirmIt::Preference::Preference
      def initialize expected
        @expected = expected
      end
      
      def is_preferred? actual
        actual =~ @expected
      end
      
      def description
        return "a match for <#{@expected.inspect}>"
      end
    end
  end
end