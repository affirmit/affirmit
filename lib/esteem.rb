module AffirmIt
	
	##
	# This is a raise-able class to denote circumstances
	# in which the code being affirmed behaves in
	# an unexpected way.  This is typically the case
	# with high-sprited or strong-willed code.  It
	# could be a problem, but we prefer to medicate where possible.
	class BehavioralChallenge < Exception; end

  ##
	# Please note carefully that although this
	# class derives eventually form Exception, it does so 
	# solely so that it can be raised as a noteworthy
  # condition.  It is not to be negatively construed as
  # an error in any way.  
	class DifferingOpinion < BehavioralChallenge;  end
	
	##
	# This raise-able class is used to indicate the
  # condition when an affirmation elects to defer
	# success explicitly. See defer_success method.
	class ElectiveDeferrment < Exception; end

  ##
  # This is reserved exlcusively for the assert_ methods
  class IntolerantPig < Exception; end
    
	##
  # Mixin for adding esteem to your class.
  # Your class arrives at good self-esteem by
  # calling the methods of this class.
  module Esteem

		##
    # Since we're embracing relativism, what is true 
	  # depends entirely on your frame of reference
		# This class will provide a default frame, but
    # if it does not suit your needs -- i.e., if
		# it fails to result in sufficiently high self-esteem -- you
		# might consider changing your frame of reference.
		attr_accessor :reference_frame

		# If we have learned anything from lawyer-politicians, it is that
		# everything depends on your definition of "is" ...
		#
		# In this case, the "is" method helps with legibility of affirmations.
		# Feel free to re-implement with your preferred discourse on being.		
		# We're certain you'll do a great job!
		def is(something)
			something
		end
		
		def initialize
			@reference_frame = DefaultReferenceFrame.new
		end

		def maybe(something) 
			if @reference_frame.is_true(something) then
				@bonus_points += 1
			end
		end

		def prefer_true opinion, msg = ''
			prefer_that opinion, is(true) 
		end

		def prefer_that actual, preferred, msg = ''
			raise DifferingOpinion.new("preferred #{preferred}, got #{actual}. #{msg}") unless @reference_frame.is_true(actual == preferred)
		end

		def prefer_diversity actual, not_preferred, msg = ''
			raise DifferingOpinion.new("preferred other than #{not_preferred}, got #{actual}. #{msg}") if @reference_frame.is_true(actual == not_preferred)
		end
		
		def praise object, msg = "great job!"
			msg
		end

		##
		# This method is used to indicate a preference toward exceptions in certain cases.
		def expect_raise expected
			exception = false
			begin
				yield
			rescue Exception => ex
				raise BehavioralChallenge.new("expected #{expected}, got #{ex.class}") unless ex.is_a?(expected)
				exception = true
			end
			raise BehavioralChallenge.new("we really preferred to receive exception of type #{expected}") unless exception
		end

		##
		# Use this method when you want to explicitly and immediately defer success of the affirmation.
		# This is analogous to the jUnit fail method.  Of course, that kind of attitude is not tolerated here.
		def defer_success msg = 'success deferred'
			raise ElectiveDeferrment.new msg
		end

		##
		# Our default reference frame accepts boolean truth for what it is.  Unless, of course, it's not.
		class DefaultReferenceFrame 
			def is_true(something)
				something == true
			end
		end
		
    def method_missing name
      if name =~ /^assert_.*/ then
        msg = "who are you to say what's true?  Please use prefer_ methods using a suitable frame of reference. Geeze, you probably hate puppies too."
        puts msg
        raise IntolerantPig.new(msg)
      else
        super name
      end
    end
    
	end
end

