require 'active_resource/formats/json_format'
require 'active_support/inflector/methods'

module MozuApi
  module JsonFormat
    include ActiveResource::Formats::JsonFormat
    extend self
    
    KEY_ITEMS = 'Items'
    
    def encode(hash, options = nil)
      ActiveSupport::JSON.encode(change_keys(hash, true), options)
    end
    
    def decode(json)
      data = ActiveSupport::JSON.decode(json)
      return data unless data.is_a?(Hash)
      change_keys(data[KEY_ITEMS] || data || {}, false)
    end
    
    def change_keys(data = {}, to_camel_case = false)
      case data
      when Array
        data.map{|x| (x.is_a?(Hash) || x.is_a?(Array)) ? change_keys(x, to_camel_case) : x}
      when Hash
        Hash[
          data.map do |k,v|
            [
              to_camel_case ? ActiveSupport::Inflector.camelize(k.to_s(), true) : ActiveSupport::Inflector.underscore(k.to_s()),
              (v.is_a?(Hash) || v.is_a?(Array)) ? change_keys(v, to_camel_case) : v
            ]
          end
        ]
      else
        data
      end
    end
  end
end