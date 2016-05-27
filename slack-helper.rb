class SlackHelper

  require 'net/http'
  require 'uri'

  def initialize config
    team_name = config[:team]
    api_token = config[:api_key]
    @channels = config[:channels].join(', ')
    @restricted = config[:restricted] || false
    @api = ApiCaller.new uri: URI("https://#{team_name}.slack.com"), base_path: "/api", post_params: { token: api_token }
    auth_test = @api.post "auth.test"
    puts "Auth text: #{JSON.parse(auth_test.body)}"
  end

  def invite(email, name)
    params = { email: email, first_name: name, channels: @channels, set_active: true, _attempts: 1 }
    params[:ultra_restricted] = true if @restricted
    @api.post "users.admin.invite?t=${Time.now.to_i}", params
  end

end
