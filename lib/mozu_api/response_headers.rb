module MozuApi
  module ResponseHeaders
    HEADER_CORRELATION = 'x-vol-correlation'.freeze()
    HEADER_MRP = 'x-vol-mrp'.freeze()
    HEADER_HAS_ERROR = 'x-vol-has-error'.freeze()
    
    def correlation()
      header(HEADER_CORRELATION)
    end
    
    def mrp()
      header(HEADER_MRP)
    end
    
    def has_error?()
      header(HEADER_HAS_ERROR) == '1'
    end
    
    
  private
    def header(name)
      return nil if self.response.nil?()
      self.response[name]
    end
  end
end