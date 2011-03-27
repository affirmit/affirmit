require 'affirmit/esteem'
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
      :preference_count, :bonus_points
    
    def initialize(listener)
      @affirmation_count = 0
      @cherished_affirmation_count = 0
      @preference_count = 0
      @bonus_points = 0
      @elective_deferrals = []
      @differing_opinions = []
      @behavioral_challenges = []
      @issues = []
      @listener = listener
    end
    
    ##
    # Embraces the given affirmation, noting any challenges
    # encountered therein.  Intolerant pigs will be
    # expelled immediately.
    def embrace affirmation
      @listener.notify :embrace_started, self, affirmation
      affirmation.embrace self
      @listener.notify :embrace_ended, self, affirmation
    end
    
    ##
    # Wraps the given affirmation in its arms, ensuring
    # that any interested parties are notified that the
    # facilitator's arms are being wrapped around, and
    # disentangled from, the given affirmation.
    def with_arms_around affirmation
      @listener.notify :wrap_arms_around, self, affirmation
      begin
        yield
      ensure
        @listener.notify :disentangle_arms_from, self, affirmation
      end
    end
    
    def cherish_affirmation
      @cherished_affirmation_count += 1
      @listener.notify :affirmation_cherished, self
    end
    
    ##
    # Registers that an individual affirmation has been
    # embraced -- not a group hug.
    def add_affirmation
      @affirmation_count += 1
      @listener.notify :affirmation_added, self
    end
    
    ##
    # Registers that an affirmation has a certain preference;
    # whether the preference is "true" or "false" in our
    # particular, subjective frame of reference does not
    # matter.
    def add_preference
      @preference_count += 1
      @listener.notify :preference_added, self
    end
    
    ##
    # Adds another bonus point to the affirmation's embrace.
    # If you get enough bonus points, it can make up for any
    # differing opinions you may have!
    def add_bonus_point
      @bonus_points += 1
      @listener.notify :bonus_point_added, self
    end
    
    ##
    # Lavish praise with the given message.
    def praise msg
      @listener.notify :praised, self, msg
    end
    
    ##
    # A facilitator may defer the success of an affirmation,
    # cherishing it until it may be praised in fullness.
    def defer_success deferral
      @elective_deferrals << deferral
      @listener.notify :success_deferred, self, deferral
    end
    
    ##
    # Facilitators may espouse differing opinions.  This is
    # not something so banal as an "failure", of course, since
    # all opinions are completely valid in their own special
    # ways.
    def espouse_differing_opinion opinion
      @differing_opinions << opinion
      @listener.notify :differing_opinion_encountered, self, opinion
    end
    
    ##
    # Some affirmations may present challenges that the
    # facilitator will note.
    def admit_challenge challenge
      @behavioral_challenges << challenge
      @listener.notify :behavioral_challenge_admitted, self, challenge
    end
    
    ##
    # Attempting to embrace an affirmation may at times raise
    # unexpected issues, noted here.
    def raise_issue exception
      @issues << exception
      @listener.notify :issue_raised, self, exception
    end
    
    ##
    # Intolerant pigs will not be tolerated by a facilitator
    # and will be expelled immediately.
    def expel pig
      @listener.notify :pig_expelled, self, pig
      Kernel.exit 3
    end
    
    def elective_deferral_count
      @elective_deferrals.size
    end
    
    def behavioral_challenge_count
      @behavioral_challenges.size
    end
    
    def differing_opinion_count
      @differing_opinions.size
    end
    
    def deferred_success_count
      @elective_deferrals.size
    end
    
    def issue_count
      @issues.size
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
  end
end
