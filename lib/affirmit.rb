require 'affirmit/commandline'

##
# AffirmIt, the application affirmation framework.
module AffirmIt
end

at_exit do
  unless $!.nil? do
    Affirmit::CommandLine.run
  end
end
