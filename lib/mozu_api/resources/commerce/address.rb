module MozuApi
  module Commerce
    class Address < Tenant::Base
      self.prefix = '/api/commerce/'
      
      class << self
        #POST /commerce/customer/addressvalidation/
        def validate(address)
          raise ArgumentError unless address.is_a?(Address)
          #response = post(:"../customer/addressvalidation/", {}, {'addressValidationRequest' => address}.to_json())
          response = connection.post("#{self.prefix}customer/addressvalidation", {'addressValidationRequest' => address}.to_json(), headers)
          instantiate_record(format.decode(response.body))
        end
      end
    end
  end
end