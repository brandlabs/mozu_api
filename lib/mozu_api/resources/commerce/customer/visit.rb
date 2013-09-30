module MozuApi
  module Commerce
    module Customer
      class Location < Tenant::Base
        self.prefix = '/api/commerce/customer/'
        self.element_name = 'locations'
      end
    end
  end
end