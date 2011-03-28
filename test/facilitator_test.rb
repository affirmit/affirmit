require 'test_helper'

module AffirmIt
  module Tests
    
    class ::AffirmIt::Facilitator
      def default_attr_hash
        {
          :affirmation_count => 1,
          :preference_count => 0,
          :deferred_success_count => 0,
          :behavioral_challenge_count => 0,
          :differing_opinion_count => 0,
          :issue_count => 0
        }
      end
    end
    
    
    class FacilitatorTest < Test::Unit::TestCase
      include AttributeAssertions
      include FacilitatorListener
      
      class NonThreateningIssue < Exception
      end
      
      class PotentiallyTroubledAffirmation < AffirmIt::Affirmation
        attr_reader :built, :recycled, :affirmed
        
        def initialize(exception_class, message)
          super('affirm_method')
          @exception_class, @message = exception_class, message
          @built, @recycled, @affirmed = false, false, false
        end
        
        def build_up
          @built = true
        end
        
        def recycle
          @recycled = true
        end
        
        def affirm_method
          @affirmed = true
        end
        
        def default_attr_hash
          {:built => true, :affirmed => true, :recycled => true}
        end
        
        def raise_issue
          raise @exception_class, @message
        end
      end
      
      
      class TroubledAffirmation < PotentiallyTroubledAffirmation
        def affirm_method
          super
          raise_issue
        end
      end
      
      
      class BuildUpChallengedAffirmation < PotentiallyTroubledAffirmation
        def build_up
          super
          raise_issue
        end
      end
      
      
      class EnvironmentallyIrresponsibleAffirmation < PotentiallyTroubledAffirmation
        def recycle
          super
          raise_issue
        end
      end
      
      
      class PotentiallyCherishedAffirmation < AffirmIt::Affirmation
        def initialize affirmed, bonus_points
          super('affirm_it')
          @affirmed = affirmed
          @bonus_points = bonus_points
        end
        
        def affirm_it
          maybe true if @bonus_points
          prefer_that @affirmed, is(true)
        end
      end
      
      
      def after_embracing affirmation
        facilitator = Facilitator.new self
        facilitator.embrace affirmation
        yield facilitator
      end
      
      def test_behavioral_challenge_during_build_up
        affirmation = BuildUpChallengedAffirmation.new BehavioralChallenge,
          'Behavioral challenge'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:behavioral_challenge_count => 1}
          assert_attributes affirmation, {:affirmed => false}
        end
      end
      
      def test_differing_opinion_during_build_up
        affirmation = BuildUpChallengedAffirmation.new DifferingOpinion,
          'Differing opinion'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:differing_opinion_count => 1}
          assert_attributes affirmation, {:affirmed => false}
        end
      end
      
      def test_elective_deferral_during_build_up
        affirmation = BuildUpChallengedAffirmation.new ElectiveDeferral,
          'Deferred success'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:deferred_success_count => 1}
          assert_attributes affirmation, {:affirmed => false}
        end
      end
      
      def test_non_threatening_issue_during_build_up
        affirmation = BuildUpChallengedAffirmation.new NonThreateningIssue,
          'Non-threatening issue'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:issue_count => 1}
          assert_attributes affirmation, {:affirmed => false}
        end
      end
      
      def test_behavioral_challenge_during_affirm_method
        affirmation = TroubledAffirmation.new BehavioralChallenge,
          'Behavioral challenge'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:behavioral_challenge_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_differing_opinion_during_affirm_method
        affirmation = TroubledAffirmation.new DifferingOpinion,
          'Differing opinion'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:differing_opinion_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_elective_deferral_during_affirm_method
        affirmation = TroubledAffirmation.new ElectiveDeferral,
          'Deferred success'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:deferred_success_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_non_threatening_issue_during_affirm_method
        affirmation = TroubledAffirmation.new NonThreateningIssue,
          'Non-threatening issue'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:issue_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_behavioral_challenge_during_recycle
        affirmation = EnvironmentallyIrresponsibleAffirmation.new BehavioralChallenge,
          'Behavioral challenge'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:behavioral_challenge_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_differing_opinion_during_recycle
        affirmation = EnvironmentallyIrresponsibleAffirmation.new DifferingOpinion,
          'Differing opinion'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:differing_opinion_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_elective_deferral_during_recycle
        affirmation = EnvironmentallyIrresponsibleAffirmation.new ElectiveDeferral,
          'Deferred success'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:deferred_success_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_non_threatening_issue_during_recycle
        affirmation = EnvironmentallyIrresponsibleAffirmation.new NonThreateningIssue,
          'Non-threatening issue'
        after_embracing affirmation do |facilitator|
          assert_attributes facilitator, {:issue_count => 1}
          assert_attributes affirmation, {}
        end
      end
      
      def test_stars_no_affirmations_makes_5
        group_hug = GroupHug.new 'Group hug'
        after_embracing group_hug do |facilitator|
          assert_equal 5.0, facilitator.stars
        end
      end
      
      def test_stars_no_affirmations_cherished_makes_3
        group_hug = GroupHug.new 'Group hug'
        group_hug << PotentiallyCherishedAffirmation.new(false, false)
        group_hug << PotentiallyCherishedAffirmation.new(false, false)
        after_embracing group_hug do |facilitator|
          assert_equal 3.0, facilitator.stars
        end
      end
      
      def test_stars_half_of_affirmations_cherished_makes_4
        group_hug = GroupHug.new 'Group hug'
        group_hug << PotentiallyCherishedAffirmation.new(true, false)
        group_hug << PotentiallyCherishedAffirmation.new(false, false)
        after_embracing group_hug do |facilitator|
          assert_equal 4.0, facilitator.stars
        end
      end
      
      def test_stars_all_affirmations_cherished_makes_5
        group_hug = GroupHug.new 'Group hug'
        group_hug << PotentiallyCherishedAffirmation.new(true, false)
        group_hug << PotentiallyCherishedAffirmation.new(true, false)
        after_embracing group_hug do |facilitator|
          assert_equal 5.0, facilitator.stars
        end
      end
      
      def test_stars_none_cherished_with_one_bonus_point_increases_stars
        group_hug = GroupHug.new 'Group hug'
        group_hug << PotentiallyCherishedAffirmation.new(false, false)
        group_hug << PotentiallyCherishedAffirmation.new(false, true)
        after_embracing group_hug do |facilitator|
          assert_equal 4.0, facilitator.stars
        end
      end
      
      def test_stars_all_cherished_with_one_bonus_point_stays_at_5
        group_hug = GroupHug.new 'Group hug'
        group_hug << PotentiallyCherishedAffirmation.new(true, true)
        group_hug << PotentiallyCherishedAffirmation.new(true, false)
        after_embracing group_hug do |facilitator|
          assert_equal 5.0, facilitator.stars
        end
      end
    end
  end
end
