module AffirmIt
  class Event
    EVENT_TYPE_DESCRIPTIONS = {
      :embrace_started => "Embrace started",
      :embrace_ended => "Embrace ended",
      :arms_wrapped_around => "Arms wrapped around an affirmation",
      :arms_disentangled_from => "Arms disentangled from an affirmation",
      :affirmation_cherished => "Affirmation cherished",
      :affirmation_added => "Affirmation added",
      :preference_added => "Preference added",
      :bonus_point_added => "Bonus point added",
      :praise => "Praise",
      :success_deferred => "Success deferred",
      :differing_opinion_encountered => "Differing opinion encountered",
      :behavioral_challenge_admitted => "Behavioral challenge admitted",
      :issue_raised => "Issue raised",
      :pig_expelled => "Intolerant pig expelled"
    }
    
    attr_reader :type
    
    def initialize type
      @type = type
    end
    
    def description
      EVENT_TYPE_DESCRIPTIONS[@type]
    end
  end
end
