module MozuApi
  module Commerce
    module Catalog
      module Storefront
        class Product < Tenant::Base
          self.prefix = '/api/commerce/catalog/storefront/'
          self.element_name = 'products'
          self.primary_key = 'product_code'
        end
      end
    end
  end
end