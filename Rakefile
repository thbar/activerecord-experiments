require 'tasks/standalone_migrations'

require 'rspec/core/rake_task'

desc "Run all RSpec tests"
RSpec::Core::RakeTask.new(:spec)

task :environment do
  yaml = YAML.load_file('db/config.yml')['development']
  ActiveRecord::Base.establish_connection(yaml)
end

task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end