require 'sinatra'
require 'json'
require 'yaml'
require './api-caller'
require './slack-helper'

set :bind, "0.0.0.0"

config = YAML::load_file 'config.yml'
slack = SlackHelper.new config

get '/' do
  @team_name = config[:team]
  @passphrase = true if config[:passphrase]
  erb :index
end

post '/get_invite' do
  if params['passphrase'] == config[:passphrase]
    @user = OpenStruct.new(params['user'])
    response = slack.invite(@user.email, @user.name)
    logger.info response
    result = JSON.parse response.body
    logger.info result

    @success = result['ok']
    @error = result['error']
  else
    @success = false
    @error = 'Wrong passphrase'
  end

  erb :get_invite
end
