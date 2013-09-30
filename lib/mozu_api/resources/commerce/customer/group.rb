module MozuApi
  module Commerce
    module Customer
      class Group < Tenant::Base
        self.prefix = '/api/commerce/customer/'
        self.element_name = 'groups'
      end
    end
  end
end