module MozuApi
  module Commerce
    module Customer
      class Account < Tenant::Base
        class Contact < Tenant::Base
          self.prefix = '/api/commerce/customer/accounts/:id/'
          self.element_name = 'contacts'
        end
      end
    end
  end
end