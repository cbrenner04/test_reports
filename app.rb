require 'sinatra'
require 'time'

# the whole thing
class App < Sinatra::Base
  include AuthenticationHelper
  include DurationHelper
  include AggregationHelper

  get '/' do
    'Integration Test Run Reports'
  end

  get '/first_runs' do
    erb :runs_index,
        locals: { runs: FirstRun.order(:created_at), type: 'First' }
  end

  # curl -H "Content-Type: application/json" -X POST -u <user>:<password>
  # -d '{"build_number":"1235","pass":"true","environment":"UAT",
  # "duration":"1234"}' http://localhost:9292/first_runs
  post '/first_runs' do
    protected!
    payload = JSON.parse(request.body.read)
    FirstRun.create(
      build_number: payload['build_number'].to_i,
      environment: payload['environment'],
      pass: payload['pass'],
      duration: payload['duration'].to_i,
      created_at: DateTime.now
    )
  end

  get '/full_runs' do
    erb :runs_index, locals: { runs: FullRun.order(:created_at), type: 'Full' }
  end

  # curl -H "Content-Type: application/json" -X POST -u <user>:<password>
  # -d '{"build_number":"1235","pass":"true","environment":"UAT",
  # "duration":"1234"}' http://localhost:9292/full_runs
  post '/full_runs' do
    protected!
    payload = JSON.parse(request.body.read)
    FullRun.create(
      build_number: payload['build_number'].to_i,
      environment: payload['environment'],
      pass: payload['pass'],
      duration: payload['duration'].to_i,
      created_at: DateTime.now
    )
  end

  get '/daily_aggregates' do
    erb :daily_aggregates_index, locals: {
      first_runs: FirstRun.order(:created_at),
      full_runs: FullRun.order(:created_at)
    }
  end

  get '/weekly_aggregates' do
    erb :weekly_aggregates_index, locals: {
      first_runs: FirstRun.order(:created_at),
      full_runs: FullRun.order(:created_at)
    }
  end
end
