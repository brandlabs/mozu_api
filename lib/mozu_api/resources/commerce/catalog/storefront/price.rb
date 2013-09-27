module MozuApi
  module Commerce
    module Catalog
      module Storefront
        class Price < MozuApi::Base
          self.element_name = '_price' #Used to fake out ActiveResource when `"Price": {"Price": $}` happens
        end
      end
    end
  end
end