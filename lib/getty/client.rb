require 'forwardable'

module Getty
  class Client
    DEFAULT_CONNECTION_MIDDLEWARE = [
      # Faraday::Response::Logger,
      FaradayMiddleware::EncodeJson,
      FaradayMiddleware::Mashify,
      FaradayMiddleware::ParseJson
    ]

    extend Forwardable

    include Sessions
    include Images

    attr_reader :system_id, :system_pwd, :user_name, :user_pwd

    #Initialize the client class that will be used for all getty API requests. 
    def initialize(options={})
      @system_id = options[:system_id] || Getty.system_id
      @system_pwd = options[:system_pwd] || Getty.system_pwd
      @user_name = options[:user_name] || Getty.user_name
      @user_pwd = options[:user_pwd] || Getty.user_pwd
      @connection_middleware = options[:connection_middleware] || Getty.connection_middleware || []
      @connection_middleware += DEFAULT_CONNECTION_MIDDLEWARE
      @ssl = options[:ssl] || { :verify => false }
    end

    def ssl
      @ssl
    end

    # Sets up the connection to be used for all requests based on options passed during initialization.

    def connection
      params = {}
      @connection ||= Faraday::Connection.new(:url => api_url, :ssl => ssl, :params => params, :headers => default_headers) do |builder|
        @connection_middleware.each do |middleware|
          builder.use *middleware
        end
        builder.adapter Faraday.default_adapter
      end
    end

    # Base URL for api requests.

    def api_url
      "https://connect.gettyimages.com/v1"
    end

    # Helper method to return errors or desired response data as appropriate.
    #
    # Added just for convenience to avoid having to traverse farther down the response just to get to returned data.

    def return_error_or_body(response, response_body)
      if response.status == 200
        response_body
      else
        raise Getty::APIError.new(response.status, response.body)
      end
    end

    private


      def default_headers
        headers = {
          :content_type => 'application/json',
          :accept =>  'application/json',
          :user_agent => 'Ruby gem'
        }
      end

  end
end
