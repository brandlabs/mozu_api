require 'net/http'

module MozuApi
  module Connection
    include ResponseHeaders
    
    attr_reader :response
    
    def handle_response(response)
      @response = response
      super(response)
    end
  end
end