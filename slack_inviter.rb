require 'sinatra'
require 'json'
require './api-caller'
require './slack-helper'

set :bind, "0.0.0.0"

slack = SlackHelper.new

get '/' do
  erb :index
end

post '/get_invite' do
  @user = OpenStruct.new(params['user'])
  response = slack.invite(@user.email, @user.nick)
  logger.info response
  result = JSON.parse response.body
  logger.info result

  @success = result['ok']
  erb :get_invite
end
