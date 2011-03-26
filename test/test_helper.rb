$: << File.expand_path('../../lib', __FILE__)
require 'test/unit'
require 'affirmit'

module AffirmIt
  module Tests
    
    AffirmIt::CommandLine.do_not_start_automatically
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
  end
end