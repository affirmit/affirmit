require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class SameAs < AffirmIt::Preference::Preference
      def initialize expected
        @expected = expected
      end
      
      def is_preferred? actual
        actual.equal? @expected
      end
      
      def description
        return "same as <#{@expected.inspect}>"
      end
    end
  end
end