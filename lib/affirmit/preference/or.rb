require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class Or < AffirmIt::Preference::Preference
      def initialize *preferences
        @preferences = preferences
      end
      
      def is_preferred? actual
        @preferences.each do |preference|
          return true if preference.is_preferred? actual
        end
        return false
      end
      
      def description
        return @preferences.collect { |preference| preference.description }.join ' or '
      end
    end
  end
end