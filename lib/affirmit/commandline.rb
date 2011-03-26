require 'affirmit/affirmation'
require 'affirmit/facilitator'
require 'affirmit/grouphug'
require 'affirmit/rosecoloredglasses'

module AffirmIt
  class CommandLine
    
    class << self
      def started?
        @started or false
      end
      
      def do_not_start_automatically
        @started = true
      end
      
      def run(args=ARGV)
        do_not_start_automatically
        affirmation_classes = []
        ::ObjectSpace.each_object(Class) do |c|
          affirmation_classes << c if c < Affirmation
        end
        group_hug = GroupHug.new('Group hug')
        affirmation_classes.sort.each { |c| group_hug << c.group_hug }
        Facilitator.new.embrace group_hug
      end
      
    end
  end
end
