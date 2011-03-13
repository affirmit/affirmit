$: << File.expand_path('../../lib', __FILE__)
require 'test/unit'
require 'affirmit'

module AffirmIt
  module Tests
    class FacilitatorTest < Test::Unit::TestCase
      
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
          assert affirmation.built
          assert (not affirmation.affirmed)
          assert affirmation.recycled
          assert_equal 1, facilitator.behavioral_challenge_count
          assert_equal 1, facilitator.affirmation_count
        end
      end
      
      def test_differing_opinion_during_build_up
        affirmation = BuildUpChallengedAffirmation.new DifferingOpinion,
          'Differing opinion'
        after_embracing affirmation do |facilitator|
          assert affirmation.built
          assert (not affirmation.affirmed)
          assert affirmation.recycled
          assert_equal 1, facilitator.differing_opinion_count
          assert_equal 1, facilitator.affirmation_count
        end
      end
    end
  end
end
