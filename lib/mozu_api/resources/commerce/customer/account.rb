module MozuApi
  module Commerce
    module Customer
      class Account < Tenant::Base
        self.prefix = '/api/commerce/customer/'
        self.element_name = 'accounts'
      end
    end
  end
end