module MozuApi
  module Commerce
    module Catalog
      module Storefront
        class Product < Tenant::Base
          self.prefix = "/api/commerce/catalog/storefront/"
          self.element_name = "products"
        end
      end
    end
  end
end