$: << File.expand_path('../../lib', __FILE__)
require 'test/unit'
require 'affirmit'

module AffirmIt
  module Tests
      
    module AttributeAssertions
      include Test::Unit::Assertions
      
      ##
      # Asserts that the given object has the given attributes.  If
      # the given object responds to :default_attr_hash, the given
      # hash will be merged with the resulting hash first.
      def assert_attributes obj, attr_hash
        default_attr_hash = {}
        if obj.respond_to? :default_attr_hash
          default_attr_hash = obj.default_attr_hash
        end
        default_attr_hash.merge(attr_hash).each_pair do |key, value|
          assert_equal value, obj.__send__(key), "Attribute #{key} of #{obj}"
        end
      end
    end
    
    
    class ::AffirmIt::Facilitator
      def default_attr_hash
        {
          :affirmation_count => 1,
          :preference_count => 0,
          :elective_deferral_count => 0,
          :behavioral_challenge_count => 0,
          :differing_opinion_count => 0,
          :issue_count => 0
        }
      end
    end
    
    
    class FacilitatorTest < Test::Unit::TestCase
      include AttributeAssertions
      
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
      
      
      def after_embracing affirmation
        facilitator = Facilitator.new
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
          assert_attributes facilitator, {:elective_deferral_count => 1}
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
          assert_attributes facilitator, {:elective_deferral_count => 1}
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
          assert_attributes facilitator, {:elective_deferral_count => 1}
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
    end
  end
end
