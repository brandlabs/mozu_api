module MozuApi
  module Commerce
    module Customer
      class Account < Tenant::Base
        class Note < Tenant::Base
          self.prefix = '/api/commerce/customer/accounts/:id/'
          self.element_name = 'notes'
        end
      end
    end
  end
end