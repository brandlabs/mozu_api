require 'net/http'

module MozuApi
  module Connection
    include ResponseHeaders
    
    attr_reader :response
    
    def handle_response(response)
      @response = response
      begin
        super(response)
      rescue ActiveResource::ConnectionError
        augment_error(response, $!)
        raise #Re-raise
      end
    end
    
    #
    # Add additional error information from the body of the response
    #
    def augment_error(response, error)
      #Must have the correct content type
      return unless response['Content-Type'].to_s().index(self.format.mime_type) == 0
      
      #Parse
      details = begin
        self.format.decode(response.body.to_s(), false)
      rescue
        {}
      end
      return if details.nil?() || details.size() < 1
      
      #Mixin our own error information
      error.extend(Error)
      error.details = details
    end
  end
end