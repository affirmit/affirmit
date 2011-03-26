require 'affirmit/preference/preference'

module AffirmIt
  module Preference
    class Not < AffirmIt::Preference::Preference
      def initialize preference
        @preference = preference
      end
      
      def is_preferred? actual
        not (@preference.is_preferred? actual)
      end
      
      def description
        return "not #{@preference.description}"
      end
    end
  end
end