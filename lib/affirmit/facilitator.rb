require 'affirmit/esteem'
require 'affirmit/event/affirmationevent'
require 'affirmit/event/event'
require 'affirmit/event/issueevent'
require 'affirmit/event/praiseevent'
require 'affirmit/facilitatorlistener'

module AffirmIt
  
  ##
  # A facilitator embraces affirmations and notifies any
  # interested classes of behavioral challenges encountered
  # with the affirmed code.  This class is similar to a
  # "test runner" in less sensitive behavioral evaluation
  # frameworks.
  class Facilitator
    
    attr_accessor :listener
    attr_reader :affirmation_count, :cherished_affirmation_count,
      :preference_count, :bonus_points, :events
    
    def initialize(listener)
      @affirmation_count = 0
      @cherished_affirmation_count = 0
      @preference_count = 0
      @bonus_points = 0
      @events = []
      @listener = listener
    end
    
    ##
    # Embraces the given affirmation, noting any challenges
    # encountered therein.  Intolerant pigs will be
    # expelled immediately.
    def embrace affirmation
      @listener.notify self, AffirmationEvent.new(:embrace_started, affirmation)
      affirmation.embrace self
      @listener.notify self, AffirmationEvent.new(:embrace_ended, affirmation)
    end
    
    ##
    # Wraps the given affirmation in its arms, ensuring
    # that any interested parties are notified that the
    # facilitator's arms are being wrapped around, and
    # disentangled from, the given affirmation.
    def with_arms_around affirmation
      @listener.notify self, AffirmationEvent.new(:arms_wrapped_around, affirmation)
      begin
        yield
      ensure
        @listener.notify self, AffirmationEvent.new(:arms_disentangled_from, affirmation)
      end
    end
    
    def cherish_affirmation
      @cherished_affirmation_count += 1
      @listener.notify self, Event.new(:affirmation_cherished)
    end
    
    ##
    # Registers that an individual affirmation has been
    # embraced -- not a group hug.
    def add_affirmation
      @affirmation_count += 1
      @listener.notify self, Event.new(:affirmation_added)
    end
    
    ##
    # Registers that an affirmation has a certain preference;
    # whether the preference is "true" or "false" in our
    # particular, subjective frame of reference does not
    # matter.
    def add_preference
      @preference_count += 1
      @listener.notify self, Event.new(:preference_added)
    end
    
    ##
    # Adds another bonus point to the affirmation's embrace.
    # If you get enough bonus points, it can make up for any
    # differing opinions you may have!
    def add_bonus_point
      @bonus_points += 1
      @listener.notify self, Event.new(:bonus_point_added)
    end
    
    ##
    # Lavish praise with the given message.
    def praise message
      add_event PraiseEvent.new(:praise, message)
    end
    
    ##
    # A facilitator may defer the success of an affirmation,
    # cherishing it until it may be praised in fullness.
    def defer_success deferral
      add_event IssueEvent.new(:success_deferred, deferral)
    end
    
    ##
    # Facilitators may espouse differing opinions.  This is
    # not something so banal as an "failure", of course, since
    # all opinions are completely valid in their own special
    # ways.
    def espouse_differing_opinion opinion
      add_event IssueEvent.new(:differing_opinion_encountered, opinion)
    end
    
    ##
    # Some affirmations may present challenges that the
    # facilitator will note.
    def admit_challenge challenge
      add_event IssueEvent.new(:behavioral_challenge_admitted, challenge)
    end
    
    ##
    # Attempting to embrace an affirmation may at times raise
    # unexpected issues, noted here.
    def raise_issue exception
      add_event IssueEvent.new(:issue_raised, exception)
    end
    
    ##
    # Intolerant pigs will not be tolerated by a facilitator
    # and will be expelled immediately.
    def expel pig
      @listener.notify self, IssueEvent.new(:pig_expelled, pig)
      Kernel.exit 3
    end
    
    def behavioral_challenge_count
      count_events :behavioral_challenge_admitted
    end
    
    def differing_opinion_count
      count_events :differing_opinion_encountered
    end
    
    def deferred_success_count
      count_events :success_deferred
    end
    
    def issue_count
      count_events :issue_raised
    end
    
    ##
    # The number of stars, from 3.0 to 5.0.  We don't want to
    # hurt anybody's feelings by giving them less than 3!
    def stars
      if @affirmation_count == 0 then
        5.0
      else
        non_cherished_affirmations = @affirmation_count - @cherished_affirmation_count - @bonus_points
        if non_cherished_affirmations <= 0
          5.0
        else
          5.0 - ((non_cherished_affirmations) * 2.0 / @affirmation_count.to_f)
        end
      end
    end
    
    def add_event event
      @events << event
      @listener.notify self, @events.last
    end
    
    def count_events type
      @events.count { |event| event.type == type }
    end
  end
end
