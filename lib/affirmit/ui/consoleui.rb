require 'affirmit/facilitator'
require 'affirmit/facilitatorlistener'

module AffirmIt
  module UI
    class ConsoleUI
      include FacilitatorListener
      
      attr_reader :output
      
      def initialize(filename = nil, output = STDOUT)
        @output = output
        @filename = filename
      end
      
      def notify event, facilitator, *args
        case event
        when :embrace_started
          if @filename.nil? then
            @output.puts "Starting group hug"
          else
            @output.puts "Starting group hug from #{@filename}"
          end
        when :affirmation_cherished
          @output.print '.'
        when :success_deferred
          @output.print 'D'
        when :differing_opinion_encountered
          @output.print 'O'
        when :behavioral_challenge_encountered
          @output.print 'B'
        when :issue_raised
          @output.print 'I'
        when :pig_expelled
          @output.print '!'
          @output.puts ''
          @output.puts args[0].message
        when :embrace_ended
          @output.puts ''
          @output.puts "There were:"
          @output.puts "  - #{facilitator.affirmation_count} affirmations (#{facilitator.cherished_affirmation_count} cherished)"
          @output.puts "  - #{facilitator.preference_count} preferences"
          @output.puts "  - #{facilitator.differing_opinion_count} differing opinions"
          @output.puts "  - #{facilitator.deferred_success_count} elective success deferrals"
          @output.puts "  - #{facilitator.behavioral_challenge_count} behavioral challenges"
          @output.puts "  - #{facilitator.issue_count} issues"
          @output.puts "  - #{facilitator.bonus_points} bonus points"
          @output.puts ''
          @output.puts "You got #{facilitator.stars.round} out of 5 gold stars!  Great job!"
        end
      end
    end
  end
end