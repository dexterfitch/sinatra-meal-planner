require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending; run `rake db:migrate`!'
end

use Rack::MethodOverride
run ApplicationController