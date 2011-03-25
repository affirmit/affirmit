require 'test_helper'

module AffirmIt
  module Tests
    class AffirmationTest < Test::Unit::TestCase
      
      class SensitiveAffirmation < AffirmIt::Affirmation
        def affirm_happiness
        end
        
        def affirm_fluffy_bunny_feet
        end
        
        def affirm_soft_pillow
        end
        
        def not_very_nice
        end
        
        def _affirm_starts_with_an_underscore
        end
      end
      
      def test_group_hug
        group_hug = SensitiveAffirmation.group_hug
        assert_equal 'AffirmIt::Tests::AffirmationTest::SensitiveAffirmation', group_hug.name
        assert_equal 3, group_hug.affirmation_count
        group_hug.each_affirmation do |affirmation|
          assert_instance_of SensitiveAffirmation, affirmation
        end
        assert_equal 'affirm_fluffy_bunny_feet', group_hug[0].method_name
        assert_equal 'affirm_happiness', group_hug[1].method_name
        assert_equal 'affirm_soft_pillow', group_hug[2].method_name
      end
      
      def test_name
        affirmation = SensitiveAffirmation.new 'affirm_happiness'
        assert_equal 'AffirmIt::Tests::AffirmationTest::SensitiveAffirmation.affirm_happiness', affirmation.name
      end
      
    end
  end
end
