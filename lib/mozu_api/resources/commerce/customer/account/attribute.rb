module MozuApi
  module Commerce
    module Customer
      class Account < Tenant::Base
        class Attribute < Tenant::Base
          self.prefix = '/api/commerce/customer/accounts/:id/'
          self.element_name = 'attributes'
        end
      end
    end
  end
end