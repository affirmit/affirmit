require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class Between < AffirmIt::Preference::Preference
      def initialize min, max
        @min, @max = min, max
      end
      
      def is_preferred? actual
        actual >= @min and actual <= @max
      end
      
      def description
        return "between <#{@min.inspect}> and <#{@max.inspect}>"
      end
    end
  end
end