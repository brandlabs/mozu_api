module MozuApi
  #TODO Data type conversion not working with JSON, only works with XML
  class Base < ActiveResource::Base
    class << self
      #
      # Changed to not allow shared headers object over subclasses
      #
      attr_writer :headers
      def headers()
        if defined?(@headers)
          @headers
        elsif superclass != Object && superclass.headers
          @headers = superclass.headers.dup()
        else
          @headers ||= {}
        end
      end
      
      #
      # Use Mozu style paths, no extenions and "new" not used
      #
      def element_path(id, prefix_options = {}, query_options = nil)
        check_prefix_options(prefix_options)

        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{URI.parser.escape id.to_s}#{query_string(query_options)}"
      end
      def new_element_path(prefix_options = {})
        "#{prefix(prefix_options)}#{collection_name}"
      end
      def collection_path(prefix_options = {}, query_options = nil)
        check_prefix_options(prefix_options)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end
      def custom_method_collection_url(method_name, options = {})
        prefix_options, query_options = split_options(options)
        "#{prefix(prefix_options)}#{collection_name}/#{method_name}#{query_string(query_options)}"
      end
      
      #
      # Mixin our own additional information for the connection
      #
      def connection(*args)
        super(*args).extend(Connection)
      end
      
      #Add header methods delegated to connection
      ResponseHeaders.instance_methods(false).each do |method|
        define_method(method) do
          self.connection.send(method)
        end unless self.respond_to?(method)
      end
    end
    
    
    self.site = 'http://sandbox.mozu.com/api'
    self.format = JsonFormat
    self.headers = {
      'User-Agent' => "mozu_api #{MozuApi::VERSION} Ruby (ActiveResource)",
      'Accept-Encoding' => 'deflate',
      'Content-Type' => self.format.mime_type
    }
    self.include_root_in_json = false
    
    
    #
    # Use Mozu style paths, no extenions and "new" not used
    #
    def custom_method_element_url(method_name, options = {})
      "#{self.class.prefix(prefix_options)}#{self.class.collection_name}/#{id}/#{method_name}#{self.class.__send__(:query_string, options)}"
    end
    def custom_method_new_element_url(method_name, options = {})
      "#{self.class.prefix(prefix_options)}#{self.class.collection_name}/#{method_name}#{self.class.__send__(:query_string, options)}"
    end
    
    <<-COMMENT
    #
    # :(
    #
    def load(attributes, remove_root = false) #TODO Remove this copied method
      raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
      @prefix_options, attributes = split_options(attributes)

      #if attributes.keys.size == 1
      #  remove_root = self.class.element_name == attributes.keys.first.to_s
      #end
      #
      #attributes = Formats.remove_root(attributes) if remove_root

      attributes.each do |key, value|
        @attributes[key.to_s] =
          case value
            when Array
              resource = nil
              value.map do |attrs|
                if attrs.is_a?(Hash)
                  resource ||= find_or_create_resource_for_collection(key)
                  resource.new(attrs)
                else
                  attrs.duplicable? ? attrs.dup : attrs
                end
              end
            when Hash
              resource = find_or_create_resource_for(key)
              resource.new(value)
            else
              value.duplicable? ? value.dup : value
          end
      end
      self
    end
    
    #
    # :(
    #
    def create_resource_for(resource_name)
      resource = self.class.const_set(resource_name, Class.new(MozuApi::Base))
      resource.prefix = self.class.prefix
      resource.site   = self.class.site
      resource
    end
    COMMENT
  end
end