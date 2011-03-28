require 'affirmit/event/event'

module AffirmIt
  class PraiseEvent < Event
    attr_reader :message
    
    def initialize type, message
      super type
      @message = message
    end
  end
end
