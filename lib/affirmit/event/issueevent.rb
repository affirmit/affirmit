require 'affirmit/event/event'

module AffirmIt
  class IssueEvent < Event
    attr_reader :issue
    
    def initialize type, issue
      super type
      @issue = issue
    end
    
    def backtrace
      @issue.backtrace.reject { |line| line =~ /^.*lib\/affirmit.*:/ }
    end
  end
end
