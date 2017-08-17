require 'pg'
require 'sequel'

DB = Sequel.connect('postgres://postgres@localhost:5432/test_reports')

%w[helpers models].each do |dir|
  Dir[File.join(Dir.pwd, dir, '**', '*.rb')].each { |file| require file }
end
require './app'

run App
