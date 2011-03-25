require 'test_helper'
require 'affirmit/rosecoloredglasses'

module AffirmIt
  module Tests
    
    class GroupHugTest < Test::Unit::TestCase
      
      class LolcatsAffirmation < AffirmIt::Affirmation
        def affirm_i_can_haz_cheezburger
        end
        
        def affirm_i_eated_it
        end
      end
      
      def setup
        # The group hug is structured as follows:
        #
        # GroupHug ('Outer group hug')
        #   GroupHug ('LolcatsAffirmation')
        #     LolcatsAffirmation.affirm_i_can_haz_cheezburger
        #     LolcatsAffirmation.affirm_i_eated_it
        #   LolcatsAffirmation.affirm_i_can_haz_cheezburger
        @group_hug = GroupHug.new 'Outer group hug'
        @group_hug << LolcatsAffirmation.group_hug
        @group_hug << LolcatsAffirmation.new('affirm_i_can_haz_cheezburger')
      end
      
      def teardown
        @group_hug = nil
      end
      
      def test_frame_of_reference_equals
        new_frame_of_reference = AffirmIt::DefaultFrameOfReference.new
        @group_hug.frame_of_reference = new_frame_of_reference
        assert_same new_frame_of_reference, @group_hug[0][0].frame_of_reference
        assert_same new_frame_of_reference, @group_hug[0][1].frame_of_reference
        assert_same new_frame_of_reference, @group_hug[1].frame_of_reference
      end
      
      def test_shift_left
        @group_hug << LolcatsAffirmation.new('affirm_i_eated_it')
        assert_equal 3, @group_hug.size
        assert_equal 'affirm_i_eated_it', @group_hug[2].method_name
      end
      
      def test_square_brackets
        assert_instance_of GroupHug, @group_hug[0]
        assert_instance_of LolcatsAffirmation, @group_hug[1]
        assert_equal 'affirm_i_can_haz_cheezburger', @group_hug[1].method_name
      end
      
      def test_each
        names = []
        @group_hug.each do |affirmation|
          names << affirmation.name
        end
        assert_equal ['AffirmIt::Tests::GroupHugTest::LolcatsAffirmation',
          'AffirmIt::Tests::GroupHugTest::LolcatsAffirmation.affirm_i_can_haz_cheezburger'],
          names
      end
      
      def test_each_affirmation
        names = []
        @group_hug.each_affirmation do |affirmation|
          names << affirmation.method_name
        end
        assert_equal ['affirm_i_can_haz_cheezburger',
          'affirm_i_eated_it', 'affirm_i_can_haz_cheezburger'],
          names
      end
      
      def test_size
        assert_equal 2, @group_hug.size
      end
      
      def test_affirmation_count
        assert_equal 3, @group_hug.affirmation_count
      end
    end
    
  end
end
