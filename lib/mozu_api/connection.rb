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
    
    def augment_error(response, error)
      error.extend(Error)
      return unless response['Content-Type'].to_s().index(self.format.mime_type) == 0
      
      details = begin
        self.format.decode(response.body.to_s()) #TODO Problem with "Items"
      rescue
        {}
      end
      return if details.nil?() || details.size() < 1
      error.details = details
    end
  end
end