class ApiCaller

  require 'net/http'
  require 'uri'
  require 'json'

  def initialize args
    args = { ssl: true, headers: {}, post_params: {} }.merge args
    @http = Net::HTTP.new(args[:uri].host, args[:uri].port)
    @http.use_ssl = args[:ssl]
    @default_headers = args[:headers]
    @default_post_params = args[:post_params]
    @base_path = args[:base_path]
  end

  def get path, headers = {}
    request = Net::HTTP:Get.new [@base_path, path].compact.join("/")
    headers = @default_headers.merge headers

    headers.each do |header_key, header_value|
      request.add_field header_key, header_value
    end

    make_request request
  end

  def post path, parameters = {}, headers = {}
    request = Net::HTTP::Post.new [@base_path, path].compact.join('/')
    headers = @default_headers.merge headers
    parameters = @default_post_params.merge parameters

    headers.each do |header_key, header_value|
      request.add_field header_key, header_value
    end

    #request.body = parameters.to_json
    request.set_form_data parameters

    make_request request
  end

  private
  def make_request request
    @http.request request
  end

end
