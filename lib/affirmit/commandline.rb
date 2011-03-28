require 'affirmit/affirmation'
require 'affirmit/facilitator'
require 'affirmit/grouphug'
require 'affirmit/rosecoloredglasses'
require 'affirmit/ui/consoleui'

module AffirmIt
  class CommandLine
    
    class << self
      def started?
        @started or false
      end
      
      def do_not_start_automatically
        @started = true
      end
      
      def run(args=ARGV, group_hug_name=$0)
        do_not_start_automatically
        affirmation_classes = []
        ::ObjectSpace.each_object(Class) do |c|
          affirmation_classes << c if c < Affirmation
        end
        group_hug = GroupHug.new(group_hug_name)
        affirmation_classes.sort.each { |c| group_hug << c.group_hug }
        
        ui = AffirmIt::UI::ConsoleUI.new
        Facilitator.new(ui).embrace group_hug
      end
      
    end
  end
end
