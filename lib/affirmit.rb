require 'affirmit/commandline'

##
# AffirmIt, the application affirmation framework.
module AffirmIt
end

at_exit do
  if $!.nil?
    AffirmIt::CommandLine.run
  end
end
