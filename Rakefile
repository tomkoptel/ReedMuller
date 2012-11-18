$:.unshift(File.dirname(__FILE__))

require 'config/environment'
require 'sinatra/activerecord/rake'
require 'bengler_test_helper/tasks'

namespace :db do

  desc "bootstrap db user, recreate, run migrations"
  task :bootstrap do
    name = "blossom"
    `createuser -sdR #{name}`
    `createdb -O #{name} #{name}_development`
    `createdb -O #{name} #{name}_test`
    Rake::Task['db:migrate'].invoke
  end

  task :migrate do
    Rake::Task["db:structure:dump"].invoke
  end

  desc "nuke db, recreate, run migrations"
  task :nuke do
    name = "patchbay"
    `dropdb #{name}_development`
    `createdb -O #{name} #{name}_development`
    Rake::Task['db:migrate'].invoke
  end

  desc "add seed data to database"
  task :seed do
    require_relative './db/seeds'
  end

end

