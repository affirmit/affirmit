require 'affirmit/esteem'

module AffirmIt
  
  ##
  # A facilitator embraces affirmations and notifies any
  # interested classes of behavioral challenges encountered
  # with the affirmed code.  This class is similar to a
  # "test runner" in less sensitive behavioral evaluation
  # frameworks.
  class Facilitator
    
    attr_reader :affirmation_count, :preference_count
    
    def initialize
      @affirmation_count = 0
      @preference_count = 0
      @elective_deferrals = []
      @differing_opinions = []
      @behavioral_challenges = []
      @issues = []
    end
    
    ##
    # Embraces the given affirmation, noting any challenges
    # encountered therein.  Intolerant pigs will be
    # expelled immediately.
    def embrace affirmation
      affirmation.embrace self
    end
    
    ##
    # Wraps the given affirmation in its arms, ensuring
    # that any interested parties are notified that the
    # facilitator's arms are being wrapped around, and
    # disentangled from, the given affirmation.
    def with_arms_around affirmation
      wrap_arms_around affirmation
      begin
        yield
      ensure
        disentangle_arms_from affirmation
      end
    end
    
    ##
    # Called when an affirmation is first embraced.
    def wrap_arms_around affirmation
    end
    
    ##
    # Called when an affirmation's embrace is lovingly
    # disengaged.
    def disentangle_arms_from affirmation
    end
    
    ##
    # Registers that an individual affirmation has been
    # embraced -- not a group hug.
    def add_affirmation
      @affirmation_count += 1
    end
    
    ##
    # Registers that an affirmation has a certain preference;
    # whether the preference is "true" or "false" in our
    # particular, subjective frame of reference does not
    # matter.
    def add_preference
      @preference_count += 1
    end
    
    ##
    # A facilitator may defer the success of an affirmation,
    # cherishing it until it may be praised in fullness.
    def defer_success deferral
      @elective_deferrals << deferral
    end
    
    ##
    # Facilitators may espouse differing opinions.  This is
    # not something so banal as an "failure", of course, since
    # all opinions are completely valid in their own special
    # ways.
    def espouse_differing_opinion opinion
      @differing_opinions << opinion
    end
    
    ##
    # Some affirmations may present challenges that the
    # facilitator will note.
    def admit_challenge challenge
      @behavioral_challenges << challenge
    end
    
    ##
    # Attempting to embrace an affirmation may at times raise
    # unexpected issues, noted here.
    def raise_issue exception
      @issues << exception
    end
    
    ##
    # Intolerant pigs will not be tolerated by a facilitator
    # and will be expelled immediately.
    def expel pig
      puts pig
      Kernel.exit 3
    end
    
    def preference_count
      @preferences.size
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
    
    def issue_count
      @issues.size
    end
  end
end
