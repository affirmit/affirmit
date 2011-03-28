require 'affirmit/event/event'

module AffirmIt
  class AffirmationEvent < Event
    attr_reader :affirmation
    
    def initialize type, affirmation
      super type
      @affirmation = affirmation
    end
  end
end
