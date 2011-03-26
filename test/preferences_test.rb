require 'test_helper'

module AffirmIt
  module Tests
    class PreferencesTest < Test::Unit::TestCase
      include AffirmIt::Preferences
      
      def test_not
        assert_pref 2, ~(is 3), "not <3>"
        assert_pref [:affirmit], ~(includes :greatness),
          "not an object that includes <:greatness>"
      end
      
      def test_not_not_preferred
        assert_not_pref 3, ~is(3), "not <3>"
      end
      
      def test_and
        assert_pref "AffirmIt", (matches /^A/) & (matches /It/),
          "a match for </^A/> and a match for </It/>"
      end
      
      def test_and_not_preferred
        assert_not_pref :ruby, (same_as :java) & (same_as :c_sharp),
          "same as <:java> and same as <:c_sharp>"
      end
      
      def test_or
        assert_pref :something_else,
          (is :something) | (is :something_else),
          "<:something> or <:something_else>"
      end
      
      def test_or_not_preferred
        assert_not_pref :ruby, (same_as :java) | (same_as :c_sharp),
          "same as <:java> or same as <:c_sharp>"
      end
      
      def test_between_equal_to_lhs
        assert_pref 2, between(2, 3), "between <2> and <3>"
      end
      
      def test_between_equal_to_rhs
        assert_pref 2, between(1, 2), "between <1> and <2>"
      end
      
      def test_between_lhs_and_rhs
        assert_pref 2, between(1, 3), "between <1> and <3>"
      end
      
      def test_between_not_preferred
        assert_not_pref 2, between(5, 6), "between <5> and <6>"
      end
      
      def test_greater_than
        assert_pref 3, (greater_than 2), "greater than <2>"
      end
      
      def test_greater_than_not_preferred
        assert_not_pref 3, (greater_than 4), "greater than <4>"
      end
      
      def test_includes
        assert_pref [:a, :b], (includes :b), "an object that includes <:b>"
      end
      
      def test_includes_not_preferred
        assert_not_pref [:a, :b], (includes :c), "an object that includes <:c>"
      end
      
      def test_is_with_value
        assert_pref 3, (is 3), "<3>"
      end
      
      def test_is_with_value_not_preferred
        assert_not_pref (2 + 2), (is 5), "<5>"
      end
      
      def test_is_with_preference
        assert_pref 3, (is between(2, 4)), "between <2> and <4>"
      end
      
      def test_is_with_preference_not_preferred
        assert_not_pref 3, (is greater_than 5), "greater than <5>"
      end
      
      def test_less_than
        assert_pref 3, (less_than 4), "less than <4>"
      end
      
      def test_less_than_not_preferred
        assert_not_pref 3, (less_than 2), "less than <2>"
      end
      
      def test_matches
        assert_pref "AffirmIt", (matches /^\w+/), "a match for </^\\w+/>"
      end
      
      def test_matches_not_preferred
        assert_not_pref "AffirmIt", (matches /testunit/), "a match for </testunit/>"
      end
      
      def test_same_as
        obj = Object.new
        assert_pref obj, (same_as obj), "same as <#{obj}>"
      end
      
      def test_same_as_not_preferred
        obj = Object.new
        assert_not_pref Object.new, (same_as obj), "same as <#{obj}>"
      end
      
      def assert_pref value, preference, description
        assert (preference.is_preferred? value)
        assert_equal description, preference.description
      end
      
      def assert_not_pref value, preference, description
        assert (not preference.is_preferred? value)
        assert_equal description, preference.description
      end
    end
  end
end