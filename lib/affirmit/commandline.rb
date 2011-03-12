require 'affirmation'
require 'facilitator'

module AffirmIt
  class CommandLine
    
    class << self
      
      def run(args=ARGV)
        affirmation_classes = []
        ::ObjectSpace.each_object(Class) do |c|
          affirmation_classes < c if c < Affirmation
        end
        affirmations = affirmation_classes.sort.collect { |c| c.new }
        Facilitator.new.embrace affirmations
      end
      
    end
  end
end
