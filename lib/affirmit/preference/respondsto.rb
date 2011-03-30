require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class RespondsTo < AffirmIt::Preference::Preference
      def initialize expected
        @expected = expected
      end
      
      def is_preferred? actual
        actual.respond_to? @expected
      end
      
      def description
        return "an object that responds to <#{@expected.inspect}>"
      end
    end
  end
end