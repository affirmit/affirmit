require 'affirmit/event/affirmationevent'
require 'affirmit/event/event'
require 'affirmit/event/issueevent'
require 'affirmit/event/praiseevent'
require 'affirmit/facilitator'
require 'affirmit/facilitatorlistener'

module AffirmIt
  module UI
    class ConsoleUI
      include FacilitatorListener
      
      attr_reader :output
      
      def initialize(output = STDOUT)
        @output = output
      end
      
      def notify facilitator, event
        case event.type
        when :embrace_started
          @output.puts "Starting group hug #{event.affirmation.name}"
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
          write_summary facilitator
          write_challenges facilitator
        end
      end
      
      def write_summary facilitator
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
      
      def write_challenges facilitator
        facilitator.events.each do |event|
          if event.is_a? IssueEvent
            @output.puts ''
            @output.puts "#{event.description}: #{event.issue.message}"
            event.backtrace.each do |line|
              @output.puts line
            end
          elsif event.is_a? PraiseEvent
            @output.puts ''
            @output.puts "#{event.description}: #{event.message}"
          end
        end
      end
    end
  end
end