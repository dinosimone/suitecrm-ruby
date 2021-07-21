require "openssl"
require "faraday"
require "json"
require "jwt"

class SuiteCRM::Connection
  class << self
    def post(endpoint, params)
      begin
        response = connection.post do |req|
          req.url endpoint
          req.headers["Content-Type"] = "application/json"
          req.body = params.to_json
        end
      rescue => e
        raise SuiteCRM::ApiException.new(e)
      end
      JSON.parse(response.body)
    end

    def get(endpoint, params)
      begin
        response = connection.get do |req|
          req.url endpoint
          req.headers["Content-Type"] = "application/json"
          req.body = params.to_json
        end
      rescue => e
        raise SuiteCRM::ApiException.new(e)
      end
      JSON.parse(response.body)
    end

    def patch(endpoint, params)
      begin
        response = connection.patch do |req|
          req.url endpoint
          req.headers["Content-Type"] = "application/json"
          req.body = params.to_json
        end
      rescue => e
        raise SuiteCRM::ApiException.new(e)
      end
      JSON.parse(response.body)
    end

    def delete(endpoint)
      begin
        response = connection.delete do |req|
          req.url endpoint
          req.headers["Content-Type"] = "application/json"
        end
      rescue => e
        raise SuiteCRM::ApiException.new(e)
      end
      JSON.parse(response.body)
    end

    private

    def connection
      set_token
      Faraday.new(url: @api_url) do |faraday|
        faraday.request :url_encoded
        faraday.options.timeout = 5
        faraday.options.open_timeout = 5
        faraday.headers["Authorization"] = @api_token
        faraday.adapter Faraday.default_adapter
      end
    end

    def set_token
      if @api_token.nil?
        @api_client_id = SuiteCRM.configuration.client_id
        @api_client_secret = SuiteCRM.configuration.client_secret
        @api_url = SuiteCRM.configuration.api_url
        @token_url = SuiteCRM.configuration.token_url
        @api_token = retrieve_token
      end

      ## Tests to see if token has expired
      t = @api_token.reverse.chomp("Bearer ".reverse).reverse
      decoded_token = JWT.decode t, nil, false
      token_exp = decoded_token[0]["exp"]
      leeway = 60
      now = Time.now.to_i
      token_window = token_exp - leeway
      refresh_token = !(token_window > now)

      if refresh_token == true
        ## Makes a call to get a new token
        @api_token = retrieve_token
      end
    end

    def retrieve_token
      response = Faraday.post(
        @token_url,
        {
          grant_type: "client_credentials",
          client_id: @api_client_id,
          client_secret: @api_client_secret
        }.to_json,
        "Content-Type" => "application/json"
      )
      @api_token = "Bearer " + JSON.parse(response.body)["access_token"]
    end
  end
end
