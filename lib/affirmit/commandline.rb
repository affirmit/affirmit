require 'affirmit/affirmation'
require 'affirmit/facilitator'
require 'affirmit/grouphug'

module AffirmIt
  class CommandLine
    
    class << self
      
      def run(args=ARGV)
        affirmation_classes = []
        ::ObjectSpace.each_object(Class) do |c|
          affirmation_classes << c if c < Affirmation
        end
        group_hug = GroupHug.new('Group hug')
        affirmation_classes.sort.each { |c| group_hug << c.new.group_hug }
        Facilitator.new.embrace group_hug
      end
      
    end
  end
end
