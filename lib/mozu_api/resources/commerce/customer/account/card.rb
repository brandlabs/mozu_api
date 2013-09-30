module MozuApi
  module Commerce
    module Customer
      class Account < Tenant::Base
        class Card < Tenant::Base
          self.prefix = '/api/commerce/customer/accounts/:id/'
          self.element_name = 'cards'
        end
      end
    end
  end
end