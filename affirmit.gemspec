Gem::Specification.new do |gem|
  gem.name              = "affirmit"
  gem.version           = "3.1.4.1.5.9.2.6.5.3.5.8.9.7.9.3.2"
  gem.platform          = Gem::Platform::RUBY
  gem.authors           = ["Eric Galluzzo","Eric Kenny"]
  gem.email             = ["affirmit@affirmit.org"]
  gem.homepage          = "http://github.com/affirmit/affirmit"
  gem.summary           = "AffirmIt! is the supportive testing framework for Ruby."
  gem.description       = "AffirmIt! is the supportive testing framework for Ruby.."
  gem.rubyforge_project = gem.name

  gem.required_rubygems_version = ">= 1.3.6"

  gem.files        = Dir["{lib}/**/*.rb", "{example}/**/*", "LICENSE", "*.md"]
  
  gem.require_path = "lib"
end
