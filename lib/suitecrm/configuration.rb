module SuiteCRM
  class Configuration
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :api_url
    attr_accessor :token_url
    attr_accessor :version

    def initialize
      @client_id      = nil
      @client_secret  = nil
      @api_url        = nil
      @token_url      = nil
      @version        = 'V8'
    end
  end
end
