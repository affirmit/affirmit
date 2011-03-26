require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class And < AffirmIt::Preference::Preference
      def initialize *preferences
        @preferences = preferences
      end
      
      def is_preferred? actual
        @preferences.each do |preference|
          return false if not preference.is_preferred? actual
        end
        return true
      end
      
      def description
        return @preferences.collect { |preference| preference.description }.join ' and '
      end
    end
  end
end