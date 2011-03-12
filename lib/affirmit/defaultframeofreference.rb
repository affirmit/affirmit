module AffirmIt
	##
	# Our default frame of reference accepts boolean truth for what
	# it is.  Unless, of course, it's not.
	class DefaultFrameOfReference 
		def is_true(something)
			something == true
		end
  end
end