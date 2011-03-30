require 'affirmit/defaultframeofreference'
require 'affirmit/preferences'

module AffirmIt
	
	##
	# This is a raise-able class to denote circumstances
	# in which the code being affirmed behaves in
	# an unexpected way.  This is typically the case
	# with high-sprited or strong-willed code.  It
	# could be a problem, but we prefer to medicate
	# where possible.
	class BehavioralChallenge < Exception; end

	##
	# Please note carefully that although this class
	# derives eventually from Exception, it does so 
	# solely so that it can be raised as a noteworthy
	# condition.  It is not to be negatively construed as
	# an error in any way.
	class DifferingOpinion < BehavioralChallenge; end
	
	##
	# This raise-able class is used to indicate the
	# condition when an affirmation elects to defer
	# success explicitly. See defer_success method.
	class ElectiveDeferral < Exception; end

	##
	# This is reserved exclusively for the assert_ methods.
	class IntolerantPig < Exception; end

	##
	# Mixin for adding esteem to your class.
	# Your class achieves good self-esteem by
	# calling the methods of this class.
	module Esteem
    include Preferences
    
    DEFAULT_PREFERENCE = AffirmIt::Preference::Is.new true

		##
		# Since we're embracing relativism, what is true
		# depends entirely on your frame of reference.
		# This class will provide a default frame, but
		# if it does not suit your needs -- i.e., if it
		# fails to result in sufficiently high
		# self-esteem -- you might consider changing
		# your frame of reference.
		attr_accessor :frame_of_reference
		
		def initialize
			@frame_of_reference = DefaultFrameOfReference.new
		end

		def maybe(something) 
			if @frame_of_reference.is_true(something) then
				add_bonus_point
			end
		end

    ##
    # Prefers that a certain value agrees with your
    # preference, thus:
    #
    # prefer_that (2 + 2), is(5)
    # prefer_that [:lisp], ((includes :infix_operators) & ~(includes :parentheses)) | (is [:ruby])
		def prefer_that actual, preference = DEFAULT_PREFERENCE, msg = ''
      add_preference
      unless @frame_of_reference.is_true(preference.is_preferred? actual)
        raise DifferingOpinion, "Preferred #{preference.description}, got <#{actual}>. #{msg}"
      end
		end
    
    ##
    # Classes that wish to note the existence of preferences
    # may override this method accordingly.
    def add_preference
    end
		
    ##
    # Classes that wish to track bonus points may override
    # this method accordingly.
    def add_bonus_point
    end
		
    ##
    # Every object needs a little encouragement sometimes.
    # Subclasses should make sure that this praise is passed
    # on to the facilitator.
    def praise object, msg = "Great job!"
		end

		##
		# This method is used to indicate a preference toward
		# exceptions in certain cases.
		def prefer_raise expected
      add_preference
      begin
				yield
			rescue Exception => ex
				raise BehavioralChallenge.new("expected #{expected}, got #{ex.class}") unless ex.is_a?(expected)
        return ex
      else
  			raise BehavioralChallenge.new("We really preferred to receive an exception of type #{expected}") unless exception
	  	end
		end

    def prefer_no_raise
      add_preference
      begin
        yield
      rescue Exception => ex
        raise BehavioralChallenge.new("We were not expecting a raise, but we got #{ex.class}")
      end
    end

		##
		# Use this method when you want to explicitly and immediately
		# defer success of the affirmation.  This is analogous to the
		# Test::Unit flunk method.  Of course, that kind of attitude
		# is not tolerated here.
		def defer_success msg = 'Success deferred'
			raise ElectiveDeferral.new msg
		end

  	def method_missing name, *args, &block
			# Some programmers will fall back to their old habits of
			# "asserting" whether something is "true" or "false".
			# We must stand firm against this sort of thinking and
			# redirect them to the preferred path.
			if name =~ /^assert_.*/ then
				msg = "Who are you to say what's true?  Please use prefer_ methods using a suitable frame of reference.  Geeze, you probably hate puppies too."
				raise IntolerantPig.new(msg)
			else
				super name, *args, &block
			end
		end

	end
end
