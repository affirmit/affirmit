require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class Includes < AffirmIt::Preference::Preference
      def initialize expected
        @expected = expected
      end
      
      def is_preferred? actual
        actual.include? @expected
      end
      
      def description
        return "an object that includes <#{@expected.inspect}>"
      end
    end
  end
end