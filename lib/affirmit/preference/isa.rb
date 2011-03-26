require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class IsA < AffirmIt::Preference::Preference
      def initialize expected
        @expected = expected
      end
      
      def is_preferred? actual
        actual.is_a? @expected
      end
      
      def description
        class_name = @expected.inspect
        article = if class_name =~ /^[AEIOUaeiou]/ then 'an' else 'a' end
        return "object that is #{article} <#{class_name}>"
      end
    end
  end
end