require "rake"
require 'rubygems'
require 'rake/gempackagetask'

gemspecfile = File.read(Dir["*.gemspec"].first)
gemspec = eval(gemspecfile)

task :default => [:all]

task :all => ["gemspec","syntax","tests","build"]

desc "Validate the gemspec"
task :gemspec do
  gemspec.validate
end

desc "Build gem locally"
task :build => :gemspec do
  system "gem build #{gemspec.name}.gemspec"
  FileUtils.mkdir "pkg" unless File.exists? "pkg"
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", "pkg"
end

desc "Install gem locally"
task :install => :build do
  system "gem install pkg/#{gemspec.name}-#{gemspec.version} --no-ri --no-rdoc"
end

desc "Clean automatically generated files"
task :clean do
  FileUtils.rm_rf "pkg"
end

desc "Check syntax"
task :syntax do
  Dir["**/*.rb"].each do |file|
    print "#{file}: "
    system("ruby -c #{file}")
  end
end

desc "Run all tests"
task :tests do
    Dir["test/**/*_test.rb"].each do |test_path|
      system "ruby -I test #{test_path}"
    end
end
