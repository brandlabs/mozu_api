module MozuApi
  module Commerce
    module Customer
      class Visit < Tenant::Base
        self.prefix = '/api/commerce/customer/'
        self.element_name = 'visits'
      end
    end
  end
end