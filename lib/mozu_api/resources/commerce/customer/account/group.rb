module MozuApi
  module Commerce
    module Customer
      class Account < Tenant::Base
        class Group < Tenant::Base
          self.prefix = '/api/commerce/customer/accounts/:id/'
          self.element_name = 'groups'
        end
      end
    end
  end
end