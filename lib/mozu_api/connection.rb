require 'net/http'

module MozuApi
  module Connection
    include ResponseHeaders
    
    attr_reader :response
    attr_reader :start_index, :page_size, :page_count, :total_count
    
    def handle_response(response)
      @response = response
      @start_index = @page_size = @page_count = @total_count = nil
      
      begin
        super(response)
        augment_success(response)
        response
      rescue ActiveResource::ConnectionError
        augment_error(response, $!)
        raise #Re-raise
      end
    end
    
    
  private
    #
    # Add additional information from the body of the response
    #
    def augment_success(response)
      return unless response['Content-Type'].to_s().index(self.format.mime_type) == 0
      
      details = begin
        self.format.decode(response.body.to_s(), false)
      rescue
        {}
      end
      
      [:start_index, :page_size, :page_count, :total_count].each do |attribute|
        self.instance_variable_set(:"@#{attribute}", details[attribute.to_s()])
      end
    end
    
    #
    # Add additional error information from the body of the response
    #
    def augment_error(response, error)
      return unless response['Content-Type'].to_s().index(self.format.mime_type) == 0
      
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